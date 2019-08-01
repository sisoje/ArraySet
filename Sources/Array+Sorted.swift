//
//  Array+Sorted.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public extension Array where Element: Comparable {
    func isSorted(ascending: Bool) -> Bool {
        return ascending ? isSorted(comparator: <=) : isSorted(comparator: >=)
    }
}

extension Array where Element: Comparable {
    func firstIndex(of element: Element, ascending: Bool) -> Int? {
        let index = findInsertionIndex(of: element, ascending: ascending, first: true)
        return index < count && self[index] == element ? index : nil
    }

    func lastIndex(of element: Element, ascending: Bool) -> Int? {
        let index = findInsertionIndex(of: element, ascending: ascending, first: false) - 1
        return index >= 0 && self[index] == element ? index : nil
    }

    func findInsertionIndex(of element: Element, ascending: Bool, first: Bool) -> Int {
        return ascending ?
            findInsertionIndex(of: element, sortedBy: <, first: first) :
            findInsertionIndex(of: element, sortedBy: >, first: first)
    }
}

private extension Array where Element: Comparable {
    func isSorted(comparator: (Element, Element) -> Bool) -> Bool {
        return first.map { reduce((true, $0)) { ($0.0 && comparator($0.1, $1), $1) }.0 } ?? true
    }

    func findInsertionIndex(of element: Element, sortedBy areInIncreasingOrder: (Element, Element) -> Bool, first: Bool) -> Int {
        var lowerBound = 0
        var upperBound = count
        while lowerBound != upperBound {
            let midIndex = (upperBound + lowerBound) / 2
            let pivot = self[midIndex]
            if areInIncreasingOrder(pivot, element) || !(first || areInIncreasingOrder(element, pivot)) {
                lowerBound = midIndex + 1
            } else {
                upperBound = midIndex
            }
        }
        return lowerBound
    }
}

public struct SortedArray<Element: Comparable> {
    public let ascending: Bool
    public private(set) var sortedElements: [Element]
}

public extension SortedArray {
    init(sortedElements: [Element], ascending: Bool) {
        assert(sortedElements.isSorted(ascending: ascending))
        self.sortedElements = sortedElements
        self.ascending = ascending
    }
}

extension SortedArray: RandomAccessCollection {
    public subscript(_ index: Int) -> Element {
        return sortedElements[index]
    }

    public func index(before i: Int) -> Int {
        return i - 1
    }

    public func index(after i: Int) -> Int {
        return i + 1
    }

    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return sortedElements.count
    }
}

extension SortedArray: SortedArrayProtocol {
    public func firstIndex(of element: Element) -> Int? {
        return sortedElements.firstIndex(of: element, ascending: ascending)
    }

    public func lastIndex(of element: Element) -> Int? {
        return sortedElements.lastIndex(of: element, ascending: ascending)
    }

    @discardableResult
    public mutating func insert(_ element: Element) -> Int {
        let index = sortedElements.findInsertionIndex(of: element, ascending: ascending, first: false)
        sortedElements.insert(element, at: index)
        return index
    }

    @discardableResult
    public mutating func remove(_ element: Element) -> Int? {
        guard let index = lastIndex(of: element) else {
            return nil
        }
        sortedElements.remove(at: index)
        return index
    }

    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        return sortedElements.remove(at: index)
    }
}

public protocol SortedArrayProtocol {
    associatedtype Element: Comparable
    mutating func insert(_ element: Element) -> Int
    mutating func remove(_ element: Element) -> Int?
    mutating func remove(at index: Int) -> Element
    func firstIndex(of element: Element) -> Int?
    func lastIndex(of element: Element) -> Int?
}
