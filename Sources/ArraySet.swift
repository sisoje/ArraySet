//
//  ArraySet.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public protocol ArraySetProtocol: RandomAccessCollection where Element: Comparable {
    var elements: [Element] { get }
    func index(of element: Element) -> Int?
    mutating func insert(_ element: Element) -> Int
    mutating func remove(_ element: Element) -> Int?
    mutating func remove(at index: Int) -> Element
}

public struct ArraySet<T: Comparable> {
    public private(set) var sortedArray: SortedArray<T>
    public init(sortedArray: SortedArray<T>) {
        self.sortedArray = sortedArray
    }
}

extension ArraySet: RandomAccessCollection {
    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return sortedArray.count
    }

    public subscript(_ index: Int) -> T {
        return sortedArray[index]
    }
}

extension ArraySet: ArraySetProtocol {
    public var elements: [T] {
        return sortedArray.sortedElements
    }

    public mutating func remove(at index: Int) -> T {
        return sortedArray.remove(at: index)
    }

    public func index(of element: T) -> Int? {
        return sortedArray.firstIndex(of: element)
    }

    public mutating func insert(_ element: T) -> Int {
        guard let index = sortedArray.firstIndex(of: element) else {
            return sortedArray.insert(element)
        }
        return index
    }

    public mutating func remove(_ element: T) -> Int? {
        return sortedArray.remove(element)
    }
}
