//
//  Tree.swift
//  RHBAVLTree
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

final class RhbNode<T> {
    var size: Int
    var element: T
    var left: RhbNode?
    var right: RhbNode?
    weak var parent: RhbNode?
    init(element: T, size: Int = 1) {
        self.element = element
        self.size = size
    }
}

extension RhbNode {
    static func level(size: Int) -> Double {
        return log2(Double(1 + size))
    }

    var sizeLeft: Int {
        return left?.size ?? 0
    }

    var sizeRight: Int {
        return right?.size ?? 0
    }

    var distanceToRoot: Int {
        return parent.map { 1 + $0.distanceToRoot } ?? 0
    }

    var pathToRoot: [RhbNode] {
        return parent.map { [$0] + $0.pathToRoot } ?? []
    }

    func rotateLeft() -> RhbNode {
        let newTop = right!
        let oldTop = self
        oldTop.replaceInParent(newTop)
        let cutOff = newTop.left
        newTop.left = oldTop
        oldTop.right = cutOff
        oldTop.parent = newTop
        cutOff?.parent = oldTop
        let cutoffSize = cutOff?.size ?? 0
        oldTop.size = 1 + oldTop.sizeLeft + cutoffSize
        newTop.size = 1 + oldTop.size + newTop.sizeRight
        return newTop
    }

    func rotateRight() -> RhbNode {
        let newTop = left!
        let oldTop = self
        oldTop.replaceInParent(newTop)
        let cutOff = newTop.right
        newTop.right = oldTop
        oldTop.left = cutOff
        oldTop.parent = newTop
        cutOff?.parent = oldTop
        let cutoffSize = cutOff?.size ?? 0
        oldTop.size = 1 + oldTop.sizeRight + cutoffSize
        newTop.size = 1 + oldTop.size + newTop.sizeLeft
        return newTop
    }

    var needsBalance: Bool {
        return abs(RhbNode.level(size: sizeLeft) - RhbNode.level(size: sizeRight)) >= 2
    }

    func rotate() -> RhbNode {
        return sizeRight > sizeLeft ? rotateLeft() : rotateRight()
    }

    func insertNode(_ node: RhbNode, comparator: (T, T) -> Bool) {
        let isLeft = comparator(node.element, element)
        if let child = isLeft ? left : right {
            child.insertNode(node, comparator: comparator)
            return
        }
        if isLeft {
            left = node
        } else {
            right = node
        }
        node.parent = self
    }

    func maxNode() -> RhbNode {
        return right?.maxNode() ?? self
    }

    func minNode() -> RhbNode {
        return left?.minNode() ?? self
    }

    func remove() {
        let useLeft = sizeLeft >= sizeRight
        let extremenode = useLeft ? left?.maxNode() : right?.minNode()
        let pivot = extremenode ?? self
        pivot.addSize(-1)
        let child = pivot.right ?? pivot.left
        pivot.replaceInParent(child)
        extremenode.map {
            element = $0.element
        }
    }

    func replaceInParent(_ node: RhbNode?) {
        if parent?.left === self {
            parent?.left = node
        }
        if parent?.right === self {
            parent?.right = node
        }
        node?.parent = parent
    }

    func findNodeWithIndex(_ index: Int) -> RhbNode? {
        let sizeLeft = left?.size ?? 0
        if sizeLeft == index {
            return self
        }
        if sizeLeft > index {
            return left?.findNodeWithIndex(index)
        }
        return right?.findNodeWithIndex(index - sizeLeft - 1)
    }

    func findNodeWithElement(_ element: T, comparator: (T, T) -> Bool, equalizer: (T, T) -> Bool) -> RhbNode? {
        if equalizer(element, self.element) {
            return self
        }
        let isLeft = comparator(element, self.element)
        let child = isLeft ? left : right
        return child?.findNodeWithElement(element, comparator: comparator, equalizer: equalizer)
    }

    func elements() -> [T] {
        return (left?.elements() ?? []) + [element] + (right?.elements() ?? [])
    }

    func print() -> String {
        let lprint = left?.print() ?? ""
        let rprint = right?.print() ?? ""
        return "[\(lprint)]<-\(element)->[\(rprint)]"
    }

    func addSize(_ val: Int) {
        size += val
        parent?.addSize(val)
    }

    func index() -> Int {
        let sizeLeft = left?.size ?? 0
        guard let parent = parent else {
            return sizeLeft
        }
        let diff = 1 + sizeLeft
        return parent.left === self ? parent.index() - diff : parent.index() + diff
    }
}
