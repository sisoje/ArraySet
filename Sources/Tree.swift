//
//  Tree.swift
//  RHBAVLTree
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

class RhbTree<T> {
    var root: RhbNode<T>?
    let comparator: (T, T) -> Bool
    let equalizer: (T, T) -> Bool
    init(comparator: @escaping (T, T) -> Bool, equalizer: @escaping (T, T) -> Bool) {
        self.comparator = comparator
        self.equalizer = equalizer
    }
}

extension RhbTree where T: Comparable {
    convenience init() {
        self.init(comparator: <, equalizer: ==)
    }
}


extension RhbTree: SortedArray {
    func removeAtIndex(_ index: Int) {
        let node = root?.findNodeWithIndex(index)
        node.map {
            removeNode($0)
        }
    }

    func insertElement(_ element: T) {
        let node = RhbNode(element: element)
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
    }

    func removeNode(_ node: RhbNode<T>) {
        node.remove()
        if root?.size == 0 {
            root = nil
        }
    }

    func removeElement(_ element: T) {
        let node = root?.findNodeWithElement(element, comparator: comparator, equalizer: equalizer)
        node.map {
            removeNode($0)
        }
    }

    func firstIndexOfElement(_ element: T) -> Int? {
        let node = root?.findNodeWithElement(element, comparator: comparator, equalizer: equalizer)
        return node?.index()
    }

    subscript(_ index: Int) -> T {
        return root!.findNodeWithIndex(index)!.element
    }

    var elements: [T] {
        return root?.elements() ?? []
    }

    var count: Int {
        return root?.size ?? 0
    }
}


