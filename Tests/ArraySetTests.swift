//
//  RHBAVLTreeTests.swift
//  RHBAVLTreeTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import XCTest
@testable import ArraySet
import GameplayKit

func makeElements(_ len: Int) -> [Int] {
    let mt = GKMersenneTwisterRandomSource(seed: 55)
    return (0..<len).map { _ in
        mt.nextInt()
    }
}
class TrivialSortedArray<T: Comparable & Equatable> {
    var elements: [T] = []
}

extension TrivialSortedArray: ArraySetProtocol {
    func removeAtIndex(_ index: Int) {
        elements.remove(at: index)
    }

    var count: Int {
        return elements.count
    }

    subscript(index: Int) -> T {
        return elements[index]
    }

    func firstIndexOfElement(_ element: T) -> Int? {
        return elements.firstIndex(of: element)
    }

    func insertElement(_ element: T) {
        elements.append(element)
        elements.sort()
    }

    func removeElement(_ element: T) {
        if let index = elements.firstIndex(of: element) {
            elements.remove(at: index)
        }
    }
}

class RHBAVLTreeTests: XCTestCase {
    func testBalance() {
        for N in 1...10 {
            let elements = Array(1..<(1 << N))
            let tree = ArraySet<Int>()
            elements.forEach(tree.insertElement)
            let distances: [Int] = elements.map {
                tree.root!.findNodeWithElement($0, comparator: tree.comparator, equalizer: tree.equalizer)!.distanceToRoot
            }
            XCTAssertLessThan(distances.max()!, 2*N)
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
        let elements = [3,1,5,0,2,4,6]
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
        let elements = makeElements(100)
        elements.enumerated().forEach { index, element in
            let tree = ArraySet<Int>()
            elements.forEach(tree.insertElement)
            var sorted = elements.sorted()
            tree.removeElement(sorted[index])
            sorted.remove(at: index)
            XCTAssertEqual(tree.elements, sorted)
        }
    }

    func testRhb() {
        let elements = makeElements(10000)
        let tree = ArraySet<Int>()
        elements.forEach(tree.insertElement)
        XCTAssertEqual(tree.elements, elements.sorted())
        measure {
            elements.forEach(tree.removeElement)
            XCTAssertEqual(tree.elements, [])
        }

    }

    func testTrivial() {
        let tree = TrivialSortedArray<Int>()
        tree.elements = makeElements(10000).sorted()
        measure {
            (0..<tree.count).forEach { _ in
                tree.removeAtIndex(tree.count/100)
            }
            XCTAssertEqual(tree.elements, [])
        }
    }
}
