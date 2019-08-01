//
//  TrivialArraySet.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public struct ArrayBackedArraySet<T: Comparable> {
    public private(set) var sortedArray: SortedArray<T>
    public init(sortedArray: SortedArray<T>) {
        self.sortedArray = sortedArray
    }
}

extension ArrayBackedArraySet: ArraySetProtocol {
    public var elements: [T] {
        return sortedArray.sortedElements
    }

    public mutating func removeElementAtIndex(_ index: Int) -> T {
        return sortedArray.remove(at: index)
    }

    public var count: Int {
        return sortedArray.count
    }

    public subscript(index: Int) -> T {
        return sortedArray[index]
    }

    public func indexOfElement(_ element: T) -> Int? {
        return sortedArray.firstIndex(of: element)
    }

    public mutating func insertElement(_ element: T) -> Int {
        guard let index = sortedArray.firstIndex(of: element) else {
            return sortedArray.insert(element)
        }
        return index
    }

    public mutating func removeElement(_ element: T) -> Int? {
        return sortedArray.remove(element)
    }
}
