//
//  Tree.swift
//  RHBAVLTree
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public protocol SortedArray {
    associatedtype T
    var count: Int { get }
    var elements: [T] { get }
    subscript(_ index: Int) -> T { get }
    func firstIndexOfElement(_ element: T) -> Int?
    func insertElement(_ element: T)
    func removeElement(_ element: T)
    func removeAtIndex(_ index: Int)
}

extension SortedArray {
    var isEmpty: Bool {
        return count == 0
    }
}
