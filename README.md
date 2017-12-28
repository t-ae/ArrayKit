# ArrayKit

`Array` utilities for Swift.

## Sort two associated `Array`s with `argsort`

```swift
let numbers = [5, 8, 2, 4]
let alphabets = ["C", "D", "A", "B"]

let order = numbers.argsort()
numbers.permuted(by: order) // [2, 4, 5, 8]
alphabets.permuted(by: order) // ["A", "B", "C", "D"]
```

## Logical functions and Masking

```swift
let mask1 = [true, true, false, false]
let mask2 = [true, false, true, false]

~mask1 // [false, false, true, true]
mask1 & mask2 // [true, false, false, false]
mask1 | mask2 // [true, true, true, false]
mask1 ^ mask2 // [false, true, true, false]

let array = [0, 1, 2, 3]
array.masked(with: mask2) // [0, 2]
```