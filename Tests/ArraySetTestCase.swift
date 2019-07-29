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
            let tree = ArraySet<Int>()
            elements.forEach(tree.insertElement)
            let distances: [Int] = elements.map {
                tree.root!.findNodeWithElement($0, comparator: tree.comparator, equalizer: tree.equalizer)!.distanceToRoot
            }
            XCTAssertLessThan(distances.max()!, 2 * N)
        }
    }

    func testEmpty() {
        let tree = ArraySet<Int>()
        XCTAssertEqual(tree.count, 0)
        XCTAssert(tree.elements.isEmpty)
    }

    func testOne() {
        let tree = ArraySet<Int>()
        let elements = [1]
        elements.forEach(tree.insertElement)
        XCTAssertEqual(tree.count, elements.count)
        XCTAssertEqual(tree.elements, elements)
        XCTAssertEqual(tree[0], elements[0])
        XCTAssertEqual(tree.firstIndexOfElement(elements[0]), 0)
        tree.removeElement(elements[0])
        XCTAssert(tree.elements.isEmpty)
    }

    func testArray() {
        let tree = ArraySet<Int>()
        let elements = [3, 1, 5, 0, 2, 4, 6]
        elements.forEach(tree.insertElement)
        XCTAssertEqual(tree.root?.left?.size, 3)
        XCTAssertEqual(tree.root?.right?.size, 3)
        let sorted = elements.sorted()
        XCTAssertEqual(tree.count, sorted.count)
        XCTAssertEqual(tree.elements, sorted)
        sorted.enumerated().forEach { index, element in
            XCTAssertEqual(tree[index], element)
            XCTAssertEqual(tree.firstIndexOfElement(element), index)
        }
    }

    func testRemove() {
        let elements = [Int].makeRandom(100)
        elements.enumerated().forEach { index, _ in
            let tree = ArraySet<Int>()
            elements.forEach(tree.insertElement)
            var sorted = elements.sorted()
            tree.removeElement(sorted[index])
            sorted.remove(at: index)
            XCTAssertEqual(tree.elements, sorted)
        }
    }

    func testRhb() {
        let elements = [Int].makeRandom(10000)
        let tree = ArraySet<Int>()
        elements.forEach(tree.insertElement)
        XCTAssertEqual(tree.elements, elements.sorted())
        measure {
            (0 ..< tree.count).forEach { _ in
                tree.removeAtIndex(tree.count / 100)
            }
            XCTAssertEqual(tree.elements, [])
        }
    }

    func testTrivial() {
        let tree = TrivialArraySet<Int>()
        tree.elements = [Int].makeRandom(10000).sorted()
        measure {
            (0 ..< tree.count).forEach { _ in
                tree.removeAtIndex(tree.count / 100)
            }
            XCTAssertEqual(tree.elements, [])
        }
    }
}
