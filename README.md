# ArraySet

This is ArraySet implementation in Swift. ArraySet is a data structure where elements are unique and sorted so you can:

- read elements directly using subscript - like an `Array`
- insert and remove elements - like a `Set`
- find index of a given element quickly


Implementation is based on keeping internal sorted array and preventing duplicates.


### Interface

```
public protocol ArraySetProtocol: RandomAccessCollection where Element: Comparable {
    var elements: [Element] { get }
    func index(of element: Element) -> Int?
    mutating func insert(_ element: Element) -> Int
    mutating func remove(_ element: Element) -> Int?
    mutating func remove(at index: Int) -> Element
}
```

### Exmple:
```
var arraySet = ArraySet<Int>()
[1, 0, 2].forEach {
    arraySet.insert($0)
}
XCTAssertEqual(arraySet.elements, [0, 1, 2])
```