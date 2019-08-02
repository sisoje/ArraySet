# ArraySet

This is ArraySet implementation in Swift. ArraySet is a data structure where elements are unique and sorted so you can:

- read elements directly using subscript - like an `Array`
- insert and remove elements - like a `Set`
- find index of a given element in O(log N) complexity


Implementation is based on keeping internal sorted array and preventing duplicates.


### Basic protocols

```
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
```

### Compounded protocols

```
protocol SortedArrayProtocol:
    RandomAccessCollection,
    SortedCollection,
    MutableIndexReversableCollection,
    IndexReversableCollection {}

protocol ArraySetProtocol:
    RandomAccessCollection,
    SortedCollection,
    MutableIndexReversableCollection,
    UniqueIndexReversableCollection {}

```

### Exmple:
```
var arraySet = ArraySet<Int>()
[1, 2, 0, 2].forEach {
    arraySet.insert($0)
}
XCTAssertEqual(arraySet.elements, [0, 1, 2])
```