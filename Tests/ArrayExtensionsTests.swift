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
        let arrMulti = [0, 0, 2, 2, 4, 4]

        XCTAssertEqual(arrMulti.findInsertionIndex(of: -1, ascending: true, first: true), 0)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: -1, ascending: true, first: false), 0)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 0, ascending: true, first: true), 0)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 0, ascending: true, first: false), 2)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 1, ascending: true, first: true), 2)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 1, ascending: true, first: false), 2)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 2, ascending: true, first: true), 2)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 2, ascending: true, first: false), 4)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 3, ascending: true, first: true), 4)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 3, ascending: true, first: false), 4)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 4, ascending: true, first: true), 4)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 4, ascending: true, first: false), 6)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 5, ascending: true, first: true), 6)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 5, ascending: true, first: false), 6)

        XCTAssertNil(arrMulti.firstIndex(of: -1, ascending: true))
        XCTAssertEqual(arrMulti.firstIndex(of: 0, ascending: true), 0)
        XCTAssertNil(arrMulti.firstIndex(of: 1, ascending: true))
        XCTAssertEqual(arrMulti.firstIndex(of: 2, ascending: true), 2)
        XCTAssertNil(arrMulti.firstIndex(of: 3, ascending: true))
        XCTAssertEqual(arrMulti.firstIndex(of: 4, ascending: true), 4)
        XCTAssertNil(arrMulti.firstIndex(of: 5, ascending: true))

        XCTAssertNil(arrMulti.lastIndex(of: -1, ascending: true))
        XCTAssertEqual(arrMulti.lastIndex(of: 0, ascending: true), 1)
        XCTAssertNil(arrMulti.lastIndex(of: 1, ascending: true))
        XCTAssertEqual(arrMulti.lastIndex(of: 2, ascending: true), 3)
        XCTAssertNil(arrMulti.lastIndex(of: 3, ascending: true))
        XCTAssertEqual(arrMulti.lastIndex(of: 4, ascending: true), 5)
        XCTAssertNil(arrMulti.lastIndex(of: 5, ascending: true))
    }

    func testDescending() {
        let arrMulti = [4, 4, 2, 2, 0, 0]

        XCTAssertEqual(arrMulti.findInsertionIndex(of: -1, ascending: false, first: true), 6)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: -1, ascending: false, first: false), 6)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 0, ascending: false, first: true), 4)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 0, ascending: false, first: false), 6)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 1, ascending: false, first: true), 4)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 1, ascending: false, first: false), 4)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 2, ascending: false, first: true), 2)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 2, ascending: false, first: false), 4)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 3, ascending: false, first: true), 2)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 3, ascending: false, first: false), 2)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 4, ascending: false, first: true), 0)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 4, ascending: false, first: false), 2)

        XCTAssertEqual(arrMulti.findInsertionIndex(of: 5, ascending: false, first: true), 0)
        XCTAssertEqual(arrMulti.findInsertionIndex(of: 5, ascending: false, first: false), 0)

        XCTAssertNil(arrMulti.firstIndex(of: -1, ascending: false))
        XCTAssertEqual(arrMulti.firstIndex(of: 0, ascending: false), 4)
        XCTAssertNil(arrMulti.firstIndex(of: 1, ascending: false))
        XCTAssertEqual(arrMulti.firstIndex(of: 2, ascending: false), 2)
        XCTAssertNil(arrMulti.firstIndex(of: 3, ascending: false))
        XCTAssertEqual(arrMulti.firstIndex(of: 4, ascending: false), 0)
        XCTAssertNil(arrMulti.firstIndex(of: 5, ascending: false))

        XCTAssertNil(arrMulti.lastIndex(of: -1, ascending: false))
        XCTAssertEqual(arrMulti.lastIndex(of: 0, ascending: false), 5)
        XCTAssertNil(arrMulti.lastIndex(of: 1, ascending: false))
        XCTAssertEqual(arrMulti.lastIndex(of: 2, ascending: false), 3)
        XCTAssertNil(arrMulti.lastIndex(of: 3, ascending: false))
        XCTAssertEqual(arrMulti.lastIndex(of: 4, ascending: false), 1)
        XCTAssertNil(arrMulti.lastIndex(of: 5, ascending: false))
    }
}
