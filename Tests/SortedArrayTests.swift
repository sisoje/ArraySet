//
//  ArraySetTestCase.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import ArraySet
import XCTest

class SortedArrayTests: XCTestCase {
    func testInsertAsc() {
        var sortedArray = SortedArray(sortedElements: [3], ascending: true)
        XCTAssertEqual(sortedArray.insert(2), 0)
        XCTAssertEqual(sortedArray.sortedElements, [2,3])
    }

    func testDesc() {
        var sortedArray = SortedArray(sortedElements: [3], ascending: false)
        XCTAssertEqual(sortedArray.insert(4), 0)
        XCTAssertEqual(sortedArray.sortedElements, [4,3])
    }

    func testRemoveAtAsc() {
        var sortedArray = SortedArray(sortedElements: [3], ascending: true)
        XCTAssertEqual(sortedArray.remove(at: 0), 3)
        XCTAssertEqual(sortedArray.sortedElements, [])
    }

    func testRemoveAtDesc() {
        var sortedArray = SortedArray(sortedElements: [3], ascending: false)
        XCTAssertEqual(sortedArray.remove(at: 0), 3)
        XCTAssertEqual(sortedArray.sortedElements, [])
    }

    func testRemoveAsc() {
        var sortedArray = SortedArray(sortedElements: [3], ascending: true)
        XCTAssertEqual(sortedArray.remove(3), 0)
        XCTAssertNil(sortedArray.remove(3))
        XCTAssertEqual(sortedArray.sortedElements, [])
    }

    func testRemoveDesc() {
        var sortedArray = SortedArray(sortedElements: [3], ascending: false)
        XCTAssertEqual(sortedArray.remove(3), 0)
        XCTAssertNil(sortedArray.remove(3))
        XCTAssertEqual(sortedArray.sortedElements, [])
    }

    func testIndexOfAsc() {
        let sortedArray = SortedArray(sortedElements: [3,3], ascending: true)
        XCTAssertEqual(sortedArray.firstIndex(of: 3), 0)
        XCTAssertEqual(sortedArray.lastIndex(of: 3), 1)
        XCTAssertNil(sortedArray.firstIndex(of: 1))
        XCTAssertNil(sortedArray.firstIndex(of: 4))
        XCTAssertNil(sortedArray.lastIndex(of: 1))
        XCTAssertNil(sortedArray.lastIndex(of: 4))
    }

    func testIndexOfDesc() {
        let sortedArray = SortedArray(sortedElements: [3,3], ascending: false)
        XCTAssertEqual(sortedArray.firstIndex(of: 3), 0)
        XCTAssertEqual(sortedArray.lastIndex(of: 3), 1)
        XCTAssertNil(sortedArray.firstIndex(of: 1))
        XCTAssertNil(sortedArray.firstIndex(of: 4))
        XCTAssertNil(sortedArray.lastIndex(of: 1))
        XCTAssertNil(sortedArray.lastIndex(of: 4))
    }

    func testCollectionAsc() {
        let sortedArray = SortedArray(sortedElements: [3], ascending: true)
        sortedArray.forEach {
            XCTAssertEqual($0, 3)
        }
        sortedArray.reversed().forEach {
            XCTAssertEqual($0, 3)
        }
    }

    func testCollectionDesc() {
        let sortedArray = SortedArray(sortedElements: [3], ascending: false)
        sortedArray.forEach {
            XCTAssertEqual($0, 3)
        }
        sortedArray.reversed().forEach {
            XCTAssertEqual($0, 3)
        }
    }
}
