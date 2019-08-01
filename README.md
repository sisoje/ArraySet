# ArraySet

This is ArraySet implementation in Swift. ArraySet is a data structure where elements are unique and sorted so you can:

- read elements directly using subscript - like an `Array`
- insert and remove elements - like a `Set`
- find index of a given element quickly


Implementation is based on balanced binary search tree (BST). Here we compromise direct acces speed in favor of insert and delete speeds.

This ArraySet is using user defined blocks for comparing elements so they don't have to implement `Comparable` or any other specific protocol.


### Interface

```
public protocol ArraySetProtocol {
	var count: Int { get } // O(1)
	var elements: [T] { get } // O(N)
	subscript(_: Int) -> T { get } // O(log N)
	func indexOfElement(_ element: T) -> Int? // O(log N)
	func insertElement(_ element: T) // O(log N)
	func removeElement(_ element: T) // O(log N)
	func removeElementAtIndex(_ index: Int) // O(log N)
}
```

### Exmple:
```
let arraySet = ArraySet<Int>()
[3, 1, 5, 0, 2, 4, 6].forEach(arraySet.insertElement)
XCTAssertEqual(arraySet.elements, [0, 1, 2, 3, 4, 5, 6])
```