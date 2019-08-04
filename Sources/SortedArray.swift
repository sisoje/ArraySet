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
        self.sortedElements = sortedElements
        self.ascending = ascending
    }

    public init<S: Sequence>(elements: S, ascending: Bool = true) where S.Element == Element {
        sortedElements = ascending ? elements.sorted(by: <) : elements.sorted(by: >)
        self.ascending = ascending
    }
}

// MARK: - public extension methods

public extension SortedArray {
    mutating func removeDuplicates() {
        sortedElements.mergeNeigbours()
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
