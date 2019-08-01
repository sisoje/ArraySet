//
//  ArraySet.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import ArraySet
import Foundation

public class BalancedTree<T: Comparable> {
    var root: BalancedTreeNode<T>?

    public init() {
        root = nil
    }
}

extension BalancedTree {
    func removeNode(_ node: BalancedTreeNode<T>) {
        node.remove()
        if root?.size == 0 {
            root = nil
        }
    }
}

extension BalancedTree: RandomAccessCollection {
    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return root?.size ?? 0
    }

    public subscript(_ index: Int) -> T {
        return root!.findNodeWithIndex(index)!.element
    }
}

extension BalancedTree: ArraySetProtocol {
    public func remove(at index: Int) -> T {
        let node = root!.findNodeWithIndex(index)!
        removeNode(node)
        return node.element
    }

    public func insert(_ element: T) -> Int {
        let node = BalancedTreeNode(element: element)
        root?.insertNode(node)
        root = root ?? node
        node.parent?.addSize(1)
        let pathToRoot = node.pathToRoot
        let nodesNeedBalancing = pathToRoot.filter { $0.needsBalance }
        let balanced = nodesNeedBalancing.map {
            $0.rotate()
        }
        if root?.parent != nil {
            root = balanced.last
        }
        return node.index()
    }

    public func remove(_ element: T) -> Int? {
        let node = root?.findNodeWithElement(element)
        node.map {
            removeNode($0)
        }
        return node?.index()
    }

    public func index(of element: T) -> Int? {
        let node = root?.findNodeWithElement(element)
        return node?.index()
    }

    public var elements: [T] {
        return root?.elements() ?? []
    }
}
