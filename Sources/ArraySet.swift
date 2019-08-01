//
//  ArraySet.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public class ArraySet<T> {
    var root: ArraySetNode<T>?
    let comparator: (T, T) -> Bool
    let equalizer: (T, T) -> Bool

    public init(comparator: @escaping (T, T) -> Bool, equalizer: @escaping (T, T) -> Bool) {
        self.comparator = comparator
        self.equalizer = equalizer
    }
}

public extension ArraySet where T: Comparable {
    convenience init() {
        self.init(comparator: <, equalizer: ==)
    }
}

extension ArraySet {
    func removeNode(_ node: ArraySetNode<T>) {
        node.remove()
        if root?.size == 0 {
            root = nil
        }
    }
}

extension ArraySet: ArraySetProtocol {
    public func removeElementAtIndex(_ index: Int) -> T {
        let node = root!.findNodeWithIndex(index)!
        removeNode(node)
        return node.element
    }

    public func insertElement(_ element: T) -> Int {
        let node = ArraySetNode(element: element)
        root?.insertNode(node, comparator: comparator)
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

    public func removeElement(_ element: T) -> Int? {
        let node = root?.findNodeWithElement(element, comparator: comparator, equalizer: equalizer)
        node.map {
            removeNode($0)
        }
        return node?.index()
    }

    public func indexOfElement(_ element: T) -> Int? {
        let node = root?.findNodeWithElement(element, comparator: comparator, equalizer: equalizer)
        return node?.index()
    }

    public subscript(_ index: Int) -> T {
        return root!.findNodeWithIndex(index)!.element
    }

    public var elements: [T] {
        return root?.elements() ?? []
    }

    public var count: Int {
        return root?.size ?? 0
    }
}
