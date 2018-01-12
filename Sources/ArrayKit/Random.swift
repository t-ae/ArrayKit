
import Foundation

// MARK: - Utilities

// Xorshift+
// https://en.wikipedia.org/wiki/Xorshift#xorshift+
var xorshift_s = [
    UInt64(arc4random_uniform(UInt32.max)) << 32 | UInt64(arc4random_uniform(UInt32.max)),
    UInt64(arc4random_uniform(UInt32.max)) << 32 | UInt64(arc4random_uniform(UInt32.max))
]
func xorshift64bit() -> UInt64 {
    var x = xorshift_s[0]
    let y = xorshift_s[1]
    
    xorshift_s[0] = y
    x ^= x << 23
    xorshift_s[1] = x ^ y ^ (x >> 17) ^ (y >> 26)
    return xorshift_s[1] &+ y
}

/// Generates random Double value from [0, 1].
func randUniform() -> Double {
    return Double(xorshift64bit()) / Double(UInt64.max)
}

/// Generates random Int value from [0, upperBound).
func randint(_ upperBound: Int) -> Int {
    return Int(xorshift64bit() % UInt64(upperBound))
}

// MARK: - Pick single element
extension Array {
    
    /// Picks one element with even odds.
    public func randomPick() -> Element? {
        guard count > 0 else {
            return nil
        }
        let index = randint(count)
        return self[index]
    }
    
    /// Picks one element.
    /// - Parameter odds: The probabilities associated with each element.
    /// - Warning: Small odds can cause computation error. Use `randomPick(cumulativeWeights:)` or `randomPick(weights:)` instead.
    public func randomPick(by odds: [Double]) -> Element? {
        return randomPick(cumulativeWeights: odds.scan(0, +))
    }
    
    /// Picks one element.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    public func randomPick(cumulativeWeights: [Double]) -> Element? {
        precondition(cumulativeWeights.count == count, "`cumulativeWeights` size must match with array size.")
        precondition(zip(cumulativeWeights, cumulativeWeights.dropFirst()).all { $0 <= $1 },
                     "`cumulativeWeights` is not ascending.")
        
        guard count > 0 else {
            return nil
        }
        
        precondition(cumulativeWeights.first! >= 0, "`cumulativeWeights` must start with positive value.")
        
        let r = randUniform() * cumulativeWeights.last!
        let index = cumulativeWeights.index { $0 > r }!
        return self[index]
    }
    
    /// Picks one element.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    public func randomPick(weights: [Int]) -> Element? {
        precondition(weights.count == count, "`weights` size must match with array size.")
        precondition(weights.all { $0 >= 0 }, "All `weights` must be positive.")
        
        guard count > 0 else {
            return nil
        }
        
        precondition(weights.some { $0 > 0 }, "Can't pick because all `weights` are 0.")
        
        let weightSum = weights.sum()!
        let r = randint(weightSum)
        var acc = 0
        for i in 0..<weights.count {
            acc += weights[i]
            if r < acc {
                return self[i]
            }
        }
        fatalError("No elements picked.")
    }
}

// MARK: - Pick multiple elements
extension Array {
    /// Picks distinct `n` elements.
    ///
    /// The order of result is not stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to pick.
    ///   - odds: The probabilities associated with each element.
    public func randomPick(n: Int) -> [Element]? {
        precondition(n >= 0, "`n` must be positive.")
        guard n <= count else {
            return nil
        }
        
        var result = [Element]()
        result.reserveCapacity(n)
        
        var rest = self
        for _ in 0..<n {
            let i = randint(rest.count)
            let e = rest.remove(at: i)
            result.append(e)
        }
        
        return result
    }
    
    /// Picks distinct `n` elements.
    ///
    /// The order of result is not stable, and elements with high odds tend to appear earlier in result.
    ///
    /// - Parameters:
    ///   - n: Number of elements to pick.
    ///   - odds: The probabilities associated with each element.
    public func randomPick(n: Int, by odds: [Double]) -> [Element]? {
        precondition(odds.count == count, "`odds` size must match with array size.")
        precondition(n >= 0, "`n` must be positive.")
        
        guard n <= count else {
            return nil
        }
        
        var odds = odds
        var rest = self
        var result = [Element]()
        result.reserveCapacity(n)
        for _ in 0..<n {
            let cumulativeOdds = odds.scan(0, +)
            let r = randUniform() * cumulativeOdds.last!
            let i = cumulativeOdds.index { r <= $0 }!
            odds.remove(at: i)
            let e = rest.remove(at: i)
            result.append(e)
        }
        return result
    }
    
    /// Picks distinct `n` elements.
    ///
    /// The order of result is not stable, and large weight elements tend to appear earlier in result.
    ///
    /// - Parameters:
    ///   - n: Number of elements to pick.
    ///   - weights: The probabilities associated with each element.
    public func randomPick(n: Int, weights: [Int]) -> [Element]? {
        precondition(n >= 0, "`n` must be positive.")
        precondition(weights.count == count, "`weights` size must match with array size.")
        precondition(weights.all { $0 >= 0 }, "All elements of `weights` mus be positive.")
        
        guard n <= count else {
            return nil
        }
        
        var weights = weights
        var rest = self
        var result = [Element]()
        result.reserveCapacity(n)
        for _ in 0..<n {
            let weightsSum = weights.sum()!
            precondition(weightsSum > 0, "Less than `n` elements have non zero weights.")
            let r = randint(weightsSum)
            
            var acc = 0
            for i in 0..<weights.count {
                acc += weights[i]
                if r < acc {
                    weights.remove(at: i)
                    let e = rest.remove(at: i)
                    result.append(e)
                    break
                }
            }
        }
        return result
    }
}

// MARK: - Generate range or slice
extension Array {
    /// Generate slice randomly with even odds.
    /// - Parameters:
    ///   - includesEmpty: If true, generated slice can be empty. Default is `false`.
    public func randomSlice(includesEmpty: Bool = false) -> ArraySlice<Element> {
        return self[randomRange(includesEmpty: includesEmpty)]
    }
    
    /// Generate random range in array.
    /// - Parameters:
    ///   - includesEmpty: If true, generated range can be empty. Default is `false`.
    public func randomRange(includesEmpty: Bool = false) -> CountableRange<Int> {
        var number: Int
        if includesEmpty {
            number = randint(count*(1+count)/2 + 1) - 1
        } else {
            number = randint(count*(1+count)/2)
        }
        
        guard number >= 0 else {
            return 0..<0
        }
        
        var index = 0
        while true {
            if number < count - index {
                return index..<index + number + 1
            }
            number -= count - index
            index += 1
        }
        preconditionFailure()
    }
}

// MARK: - Shuffle
extension Array {
    /// Shuffles array.
    public mutating func shuffle() {
        guard count > 0 else {
            return
        }
        
        for i in (1..<count).reversed() {
            let r = randint(i+1)
            let temp = self[i]
            self[i] = self[r]
            self[r] = temp
        }
    }
    
    /// Shuffles array.
    public func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }
}
