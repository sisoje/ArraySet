# ArraySet
ArraySet implementation in Swift

```
public protocol ArraySetProtocol {
associatedtype T
var count: Int { get }
var elements: [T] { get }
subscript(_: Int) -> T { get }
func firstIndexOfElement(_ element: T) -> Int?
func insertElement(_ element: T)
func removeElement(_ element: T)
func removeAtIndex(_ index: Int)
}
```
