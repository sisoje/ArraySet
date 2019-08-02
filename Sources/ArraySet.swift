//
//  ArraySet.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public struct ArraySet<Element: Comparable>: ArraySetProtocol {
    public private(set) var sortedArray: SortedArray<Element>

    public init(sortedArray: SortedArray<Element> = SortedArray()) {
        assert(sortedArray.areElementsUnique)
        self.sortedArray = sortedArray
    }
}

// MARK: - SortedCollection

extension ArraySet: SortedCollection {
    public var sortedElements: [Element] {
        return sortedArray.sortedElements
    }
}

// MARK: - RandomAccessCollection

extension ArraySet: RandomAccessCollection {
    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return sortedArray.count
    }

    public subscript(_ index: Int) -> Element {
        return sortedArray[index]
    }
}

// MARK: - UniqueIndexReversableCollection

extension ArraySet: UniqueIndexReversableCollection {
    public func index(of element: Element) -> Int? {
        return sortedArray.firstIndex(of: element)
    }
}

// MARK: - MutableIndexReversableCollection

extension ArraySet: MutableIndexReversableCollection {
    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        return sortedArray.remove(at: index)
    }

    @discardableResult
    public mutating func insert(_ element: Element) -> Int {
        return sortedArray.firstIndex(of: element) ?? sortedArray.insert(element)
    }

    @discardableResult
    public mutating func remove(_ element: Element) -> Int? {
        return sortedArray.remove(element)
    }
}
