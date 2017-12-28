# ArrayKit

`Array` utilities for Swift.

## Statistic functions
```swift
let array = [0, 1, 2, 3, 4]
array.sum()! // 10
array.mean()! // 2.0
array.variance()! // 2.0
```

## Random pick/shuffle
```swift
let array = [3, 4, 5, 6]
array.randomPick()! // Pick random element
array.shuffled() // Shuffled array
```

## Sort two associated `Array`s with `argsort`

```swift
let numbers = [5, 8, 2, 4]
let alphabets = ["C", "D", "A", "B"]

let order = numbers.argsort()
numbers.permuted(by: order) // [2, 4, 5, 8]
alphabets.permuted(by: order) // ["A", "B", "C", "D"]
```

## Logical operators and Masking

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

## Iterate Combinations/Permutations/SubSequences

```swift
let array = [3, 4, 5]
array.combinations(k: 2) // Sequence of [3, 4], [3, 5], [4, 5]
array.permutations(k: 2) // Sequence of [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4]
array.subSequences() // Sequence of [], [3], [4], [5], [3, 4], [4, 5], [3, 4, 5]
```

## Example
[Solve one max problem with Genetic Algorithm](https://github.com/t-ae/ArrayKit/blob/master/Tests/ArrayKitTests/OneMaxTests.swift)