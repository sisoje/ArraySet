//
//  Protocols.swift
//  ArraySet
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import Foundation

// MARK: - basic protocols

public protocol SortedCollection {
    associatedtype Element: Comparable
    var sortedElements: [Element] { get }
}

public protocol MutableIndexReversableCollection {
    associatedtype Element
    mutating func remove(at index: Int) -> Element
    mutating func insert(_ element: Element) -> Int
    mutating func remove(_ element: Element) -> Int?
}

public protocol IndexReversableCollection {
    associatedtype Element
    func firstIndex(of element: Element) -> Int?
    func lastIndex(of element: Element) -> Int?
}

public protocol UniqueIndexReversableCollection {
    associatedtype Element
    func index(of element: Element) -> Int?
}

// MARK: - compounded protocols

protocol SortedArrayProtocol:
    RandomAccessCollection,
    Equatable,
    SortedCollection,
    MutableIndexReversableCollection,
    IndexReversableCollection {}

protocol ArraySetProtocol:
    RandomAccessCollection,
    Equatable,
    SortedCollection,
    MutableIndexReversableCollection,
    UniqueIndexReversableCollection {}
