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
    func testBalance() {
        for N in 1 ... 10 {
            let elements = Array(1 ..< (1 << N))
            let arraySet = ArraySet<Int>()
            elements.forEach { arraySet.insertElement($0) }
            let distances: [Int] = elements.map {
                arraySet.root!.findNodeWithElement($0, comparator: arraySet.comparator, equalizer: arraySet.equalizer)!.distanceToRoot
            }
            XCTAssertLessThan(distances.max()!, 2 * N)
        }
    }

    func testEmpty() {
        let arraySet = ArraySet<Int>()
        XCTAssertNil(arraySet.root)
        XCTAssertEqual(arraySet.count, 0)
        XCTAssert(arraySet.isEmpty)
        XCTAssertEqual(arraySet.elements, [])
    }

    func testOne() {
        let arraySet = ArraySet<Int>()
        let elements = [1]
        elements.forEach { arraySet.insertElement($0) }
        XCTAssertFalse(arraySet.isEmpty)
        XCTAssertEqual(arraySet.count, elements.count)
        XCTAssertEqual(arraySet.elements, elements)
        XCTAssertEqual(arraySet[0], elements[0])
        XCTAssertEqual(arraySet.indexOfElement(elements[0]), 0)
        arraySet.removeElement(elements[0])
        XCTAssertNil(arraySet.root)
        XCTAssertEqual(arraySet.count, 0)
        XCTAssert(arraySet.isEmpty)
        XCTAssertEqual(arraySet.elements, [])
    }

    func testSmallArray() {
        let elements = [3, 1, 5, 0, 2, 4, 6]
        let sorted = [0, 1, 2, 3, 4, 5, 6]
        let arraySet = ArraySet<Int>()
        elements.forEach { arraySet.insertElement($0) }
        XCTAssertEqual(arraySet.elements, sorted)
        sorted.enumerated().forEach { index, element in
            XCTAssertEqual(arraySet[index], element)
            XCTAssertEqual(arraySet.indexOfElement(element), index)
        }
        XCTAssertEqual(arraySet.root?.left?.size, 3)
        XCTAssertEqual(arraySet.root?.right?.size, 3)
    }

    func testRemove() {
        let elements = [Int].makeRandom(100)
        elements.enumerated().forEach { index, _ in
            let tree = ArraySet<Int>()
            elements.forEach { tree.insertElement($0) }
            var sorted = elements.sorted()
            tree.removeElement(sorted[index])
            sorted.remove(at: index)
            XCTAssertEqual(tree.elements, sorted)
        }
    }

    func testLargeArraySet() {
        let elements = [Int].makeRandom(1000)
        let tree = ArraySet<Int>()
        measure {
            elements.forEach { tree.insertElement($0) }
            XCTAssertEqual(tree.elements, elements.sorted())
            elements.forEach { tree.removeElement($0) }
            XCTAssertEqual(tree.elements, [])
        }
    }

    func testLargeArraySetTrivial() {
        let elements = [Int].makeRandom(1000)

        var tree = ArrayBackedArraySet<Int>(sortedArray: SortedArray<Int>(sortedElements: [], ascending: true))
        measure {
            elements.forEach { tree.insertElement($0) }
            XCTAssertEqual(tree.elements, elements.sorted())
            elements.forEach { tree.removeElement($0) }
            XCTAssertEqual(tree.elements, [])
        }
    }
}
