//
//  ArraySetTestCase.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

@testable import ArraySet
import XCTest

class BalancedTreeTestCase: XCTestCase {
    func testBalance() {
        for N in 1 ... 10 {
            let elements = Array(1 ..< (1 << N))
            let arraySet = BalancedTree<Int>()
            elements.forEach { arraySet.insert($0) }
            let distances: [Int] = elements.map {
                arraySet.root!.findNodeWithElement($0)!.distanceToRoot
            }
            XCTAssertLessThan(distances.max()!, 2 * N)
        }
    }

    func testEmpty() {
        let arraySet = BalancedTree<Int>()
        XCTAssertNil(arraySet.root)
        XCTAssertEqual(arraySet.count, 0)
        XCTAssert(arraySet.isEmpty)
        XCTAssertEqual(arraySet.sortedElements, [])
    }

    func testOne() {
        let arraySet = BalancedTree<Int>()
        let elements = [1]
        elements.forEach { arraySet.insert($0) }
        XCTAssertFalse(arraySet.isEmpty)
        XCTAssertEqual(arraySet.count, elements.count)
        XCTAssertEqual(arraySet.sortedElements, elements)
        XCTAssertEqual(arraySet[0], elements[0])
        XCTAssertEqual(arraySet.index(of: elements[0]), 0)
        arraySet.remove(elements[0])
        XCTAssertNil(arraySet.root)
        XCTAssertEqual(arraySet.count, 0)
        XCTAssert(arraySet.isEmpty)
        XCTAssertEqual(arraySet.sortedElements, [])
    }

    func testSmallArray() {
        let elements = [3, 1, 5, 0, 2, 4, 6]
        let sorted = [0, 1, 2, 3, 4, 5, 6]
        let arraySet = BalancedTree<Int>()
        elements.forEach { arraySet.insert($0) }
        XCTAssertEqual(arraySet.sortedElements, sorted)
        sorted.enumerated().forEach { index, element in
            XCTAssertEqual(arraySet[index], element)
            XCTAssertEqual(arraySet.index(of: element), index)
        }
        XCTAssertEqual(arraySet.root?.left?.size, 3)
        XCTAssertEqual(arraySet.root?.right?.size, 3)
    }

    func testRemove() {
        let elements = [Int].makeRandom(100)
        elements.enumerated().forEach { index, _ in
            let tree = BalancedTree<Int>()
            elements.forEach { tree.insert($0) }
            var sorted = elements.sorted()
            tree.remove(sorted[index])
            sorted.remove(at: index)
            XCTAssertEqual(tree.sortedElements, sorted)
        }
    }

    func testLargeArraySet() {
        let elements = [Int].makeRandom(1000)
        let tree = BalancedTree<Int>()
        measure {
            elements.forEach { tree.insert($0) }
            XCTAssertEqual(tree.sortedElements, elements.sorted())
            elements.forEach { tree.remove($0) }
            XCTAssertEqual(tree.sortedElements, [])
        }
    }
}
