//
//  ArraySetTestCase.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

@testable import ArraySet
import XCTest

class ArrayExtensionsTests: XCTestCase {
    func testAscending() {
        let arrayAsc = [0, 0, 2, 2, 4, 4]
        let ascending = true

        XCTAssertEqual(arrayAsc.findInsertionIndex(of: -1, ascending: ascending, first: true), 0)
        XCTAssertEqual(arrayAsc.findInsertionIndex(of: -1, ascending: ascending, first: false), 0)

        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 0, ascending: ascending, first: true), 0)
        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 0, ascending: ascending, first: false), 2)

        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 1, ascending: ascending, first: true), 2)
        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 1, ascending: ascending, first: false), 2)

        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 2, ascending: ascending, first: true), 2)
        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 2, ascending: ascending, first: false), 4)

        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 3, ascending: ascending, first: true), 4)
        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 3, ascending: ascending, first: false), 4)

        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 4, ascending: ascending, first: true), 4)
        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 4, ascending: ascending, first: false), 6)

        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 5, ascending: ascending, first: true), 6)
        XCTAssertEqual(arrayAsc.findInsertionIndex(of: 5, ascending: true, first: false), 6)

        XCTAssertNil(arrayAsc.firstIndex(of: -1, ascending: ascending))
        XCTAssertEqual(arrayAsc.firstIndex(of: 0, ascending: ascending), 0)
        XCTAssertNil(arrayAsc.firstIndex(of: 1, ascending: ascending))
        XCTAssertEqual(arrayAsc.firstIndex(of: 2, ascending: ascending), 2)
        XCTAssertNil(arrayAsc.firstIndex(of: 3, ascending: ascending))
        XCTAssertEqual(arrayAsc.firstIndex(of: 4, ascending: ascending), 4)
        XCTAssertNil(arrayAsc.firstIndex(of: 5, ascending: ascending))

        XCTAssertNil(arrayAsc.lastIndex(of: -1, ascending: ascending))
        XCTAssertEqual(arrayAsc.lastIndex(of: 0, ascending: ascending), 1)
        XCTAssertNil(arrayAsc.lastIndex(of: 1, ascending: ascending))
        XCTAssertEqual(arrayAsc.lastIndex(of: 2, ascending: ascending), 3)
        XCTAssertNil(arrayAsc.lastIndex(of: 3, ascending: ascending))
        XCTAssertEqual(arrayAsc.lastIndex(of: 4, ascending: ascending), 5)
        XCTAssertNil(arrayAsc.lastIndex(of: 5, ascending: ascending))
    }

    func testDescending() {
        let arrayDesc = [4, 4, 2, 2, 0, 0]
        let ascending = false

        XCTAssertEqual(arrayDesc.findInsertionIndex(of: -1, ascending: ascending, first: true), 6)
        XCTAssertEqual(arrayDesc.findInsertionIndex(of: -1, ascending: ascending, first: false), 6)

        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 0, ascending: ascending, first: true), 4)
        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 0, ascending: ascending, first: false), 6)

        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 1, ascending: ascending, first: true), 4)
        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 1, ascending: ascending, first: false), 4)

        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 2, ascending: ascending, first: true), 2)
        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 2, ascending: ascending, first: false), 4)

        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 3, ascending: ascending, first: true), 2)
        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 3, ascending: ascending, first: false), 2)

        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 4, ascending: ascending, first: true), 0)
        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 4, ascending: ascending, first: false), 2)

        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 5, ascending: ascending, first: true), 0)
        XCTAssertEqual(arrayDesc.findInsertionIndex(of: 5, ascending: ascending, first: false), 0)

        XCTAssertNil(arrayDesc.firstIndex(of: -1, ascending: ascending))
        XCTAssertEqual(arrayDesc.firstIndex(of: 0, ascending: ascending), 4)
        XCTAssertNil(arrayDesc.firstIndex(of: 1, ascending: ascending))
        XCTAssertEqual(arrayDesc.firstIndex(of: 2, ascending: ascending), 2)
        XCTAssertNil(arrayDesc.firstIndex(of: 3, ascending: ascending))
        XCTAssertEqual(arrayDesc.firstIndex(of: 4, ascending: ascending), 0)
        XCTAssertNil(arrayDesc.firstIndex(of: 5, ascending: ascending))

        XCTAssertNil(arrayDesc.lastIndex(of: -1, ascending: ascending))
        XCTAssertEqual(arrayDesc.lastIndex(of: 0, ascending: ascending), 5)
        XCTAssertNil(arrayDesc.lastIndex(of: 1, ascending: ascending))
        XCTAssertEqual(arrayDesc.lastIndex(of: 2, ascending: ascending), 3)
        XCTAssertNil(arrayDesc.lastIndex(of: 3, ascending: ascending))
        XCTAssertEqual(arrayDesc.lastIndex(of: 4, ascending: ascending), 1)
        XCTAssertNil(arrayDesc.lastIndex(of: 5, ascending: ascending))
    }

    func testMergeNeighbours012() {
        var array = [0, 0, 1, 2, 2]
        array.mergeNeigbours()
        XCTAssertEqual(array, [0, 1, 2])
    }

    func testMergeNeighboursEmpty() {
        var array: [Int] = []
        array.mergeNeigbours()
        XCTAssertEqual(array, [])
    }

    func testMergeNeighbours1() {
        var array = [1]
        array.mergeNeigbours()
        XCTAssertEqual(array, [1])
    }

    func testMergeNeighbours11() {
        var array: [Int] = [1, 1]
        array.mergeNeigbours()
        XCTAssertEqual(array, [1])
    }

    func testMergeNeighbours12() {
        var array = [1, 2]
        array.mergeNeigbours()
        XCTAssertEqual(array, [1, 2])
    }

    func testIsSorted012() {
        let array = [0, 1, 2]
        XCTAssertTrue(array.isSorted(ascending: true))
        XCTAssertFalse(array.isSorted(ascending: false))
    }

    func testIsSorted210() {
        let array = [2, 1, 0]
        XCTAssertFalse(array.isSorted(ascending: true))
        XCTAssertTrue(array.isSorted(ascending: false))
    }

    func testIsSorted111() {
        let array = [1, 1, 1]
        XCTAssertTrue(array.isSorted(ascending: true))
        XCTAssertTrue(array.isSorted(ascending: false))
    }

    func testIsSortedEmpty() {
        let array: [Int] = []
        XCTAssertTrue(array.isSorted(ascending: true))
        XCTAssertTrue(array.isSorted(ascending: false))
    }
}
