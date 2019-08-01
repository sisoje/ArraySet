//
//  ArraySetProtocol.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

public protocol ArraySetProtocol {
    associatedtype T
    var count: Int { get }
    var elements: [T] { get }
    subscript(_: Int) -> T { get }
    func indexOfElement(_ element: T) -> Int?
    mutating func insertElement(_ element: T) -> Int
    mutating func removeElement(_ element: T) -> Int?
    mutating func removeElementAtIndex(_ index: Int) -> T
}

public extension ArraySetProtocol {
    var isEmpty: Bool {
        return count == 0
    }
}
