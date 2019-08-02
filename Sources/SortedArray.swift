//
//  SortedArray.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public struct SortedArray<Element: Comparable>: SortedArrayProtocol {
    public private(set) var sortedElements: [Element]
    public let ascending: Bool

    public init(sortedElements: [Element] = [], ascending: Bool = true) {
        assert(sortedElements.isSorted(ascending: ascending))
        self.sortedElements = sortedElements
        self.ascending = ascending
    }
}

// MARK: - public extension methods

public extension SortedArray {
    var areElementsUnique: Bool {
        return first.map { reduce((true, $0)) { ($0.0 && $0.1 != $1, $1) }.0 } ?? true
    }
}

// MARK: - RandomAccessCollection

extension SortedArray: RandomAccessCollection {
    public subscript(_ index: Int) -> Element {
        return sortedElements[index]
    }

    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return sortedElements.count
    }
}

// MARK: - IndexReversableCollection

extension SortedArray: IndexReversableCollection {
    public func firstIndex(of element: Element) -> Int? {
        return sortedElements.firstIndex(of: element, ascending: ascending)
    }

    public func lastIndex(of element: Element) -> Int? {
        return sortedElements.lastIndex(of: element, ascending: ascending)
    }
}

// MARK: - MutableIndexReversableCollection

extension SortedArray: MutableIndexReversableCollection {
    @discardableResult
    public mutating func insert(_ element: Element) -> Int {
        let index = sortedElements.findInsertionIndex(of: element, ascending: ascending, first: false)
        sortedElements.insert(element, at: index)
        return index
    }

    @discardableResult
    public mutating func remove(_ element: Element) -> Int? {
        return lastIndex(of: element).map {
            sortedElements.remove(at: $0)
            return $0
        }
    }

    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        return sortedElements.remove(at: index)
    }
}
