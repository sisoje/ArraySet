//
//  SortedArray.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public protocol SortedArrayProtocol: RandomAccessCollection where Element: Comparable {
    mutating func insert(_ element: Element) -> Int
    mutating func remove(_ element: Element) -> Int?
    mutating func remove(at index: Int) -> Element
    func firstIndex(of element: Element) -> Int?
    func lastIndex(of element: Element) -> Int?
}

public extension SortedArrayProtocol {
    var areElementsUnique: Bool {
        return first.map { reduce((true, $0)) { ($0.0 && $0.1 != $1, $1) }.0 } ?? true
    }
}

public struct SortedArray<Element: Comparable> {
    public let ascending: Bool
    public private(set) var sortedElements: [Element]
}

public extension SortedArray {
    init(sortedElements: [Element] = [], ascending: Bool = true) {
        assert(sortedElements.isSorted(ascending: ascending))
        self.sortedElements = sortedElements
        self.ascending = ascending
    }
}

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
