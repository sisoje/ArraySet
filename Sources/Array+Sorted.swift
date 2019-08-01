//
//  Array+Sorted.swift
//  ArraySet
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
        var (lowerBound, upperBound) = (0, count)
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
