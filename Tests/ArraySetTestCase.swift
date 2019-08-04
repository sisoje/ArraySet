//
//  ArraySetTestCase.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

@testable import ArraySet
import XCTest

class ArraySetTestCase: XCTestCase {
    func testLargeArraySetUnsorted() {
        let arraySet = ArraySet(elements: [1, 2, 0, 2])
        XCTAssertEqual(arraySet.sortedElements, [0, 1, 2])
    }

    func testRemoveDupliEmpty() {
        var sa = SortedArray<Int>()
        sa.removeDuplicates()
        XCTAssertEqual(sa.sortedElements, [])
    }

    func testRemoveDupli1() {
        var sa = SortedArray(elements: [1])
        sa.removeDuplicates()
        XCTAssertEqual(sa.sortedElements, [1])
    }

    func testRemoveDupli11() {
        var sa = SortedArray(elements: [1, 1])
        sa.removeDuplicates()
        XCTAssertEqual(sa.sortedElements, [1])
    }

    func testRemoveDupli12() {
        var sa = SortedArray(elements: [1, 2])
        sa.removeDuplicates()
        XCTAssertEqual(sa.sortedElements, [1, 2])
    }
}
