//
//  ArraySet.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public struct ArraySet<Element: Comparable>: ArraySetProtocol {
    public private(set) var sortedArrayWithoutDuplicates: SortedArray<Element>

    public init(sortedArrayWithoutDuplicates: SortedArray<Element> = SortedArray()) {
        self.sortedArrayWithoutDuplicates = sortedArrayWithoutDuplicates
    }

    public init<S: Sequence>(elements: S, ascending: Bool = true) where S.Element == Element {
        sortedArrayWithoutDuplicates = SortedArray(elements: elements, ascending: ascending)
        sortedArrayWithoutDuplicates.removeDuplicates()
    }
}

// MARK: - SortedCollection

extension ArraySet: SortedCollection {
    public var sortedElements: [Element] {
        return sortedArrayWithoutDuplicates.sortedElements
    }
}

// MARK: - RandomAccessCollection

extension ArraySet: RandomAccessCollection {
    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return sortedArrayWithoutDuplicates.count
    }

    public subscript(_ index: Int) -> Element {
        return sortedArrayWithoutDuplicates[index]
    }
}

// MARK: - UniqueIndexReversableCollection

extension ArraySet: UniqueIndexReversableCollection {
    public func index(of element: Element) -> Int? {
        return sortedArrayWithoutDuplicates.firstIndex(of: element)
    }
}

// MARK: - MutableIndexReversableCollection

extension ArraySet: MutableIndexReversableCollection {
    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        return sortedArrayWithoutDuplicates.remove(at: index)
    }

    @discardableResult
    public mutating func insert(_ element: Element) -> Int {
        return sortedArrayWithoutDuplicates.firstIndex(of: element) ?? sortedArrayWithoutDuplicates.insert(element)
    }

    @discardableResult
    public mutating func remove(_ element: Element) -> Int? {
        return sortedArrayWithoutDuplicates.remove(element)
    }
}
