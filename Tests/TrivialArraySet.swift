//
//  TrivialArraySet.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation
import ArraySet

class TrivialArraySet<T: Comparable & Equatable> {
    var elements: [T] = []
}

extension TrivialArraySet: ArraySetProtocol {
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
