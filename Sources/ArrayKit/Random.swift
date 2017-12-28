
import Foundation

var xorshift_state_x = UInt64(arc4random()) << 32 | UInt64(arc4random())
var xorshift_state_y = UInt64(arc4random()) << 32 | UInt64(arc4random())
var xorshift_state_z = UInt64(arc4random()) << 32 | UInt64(arc4random())
var xorshift_state_t: UInt64 = 0
func xorshift64bit() -> UInt64 {
    xorshift_state_t = (xorshift_state_x ^ (xorshift_state_x << 3))
        ^ (xorshift_state_y ^ (xorshift_state_y >> 19))
        ^ (xorshift_state_z ^ (xorshift_state_z << 6))
    xorshift_state_x = xorshift_state_y
    xorshift_state_y = xorshift_state_z
    xorshift_state_z = xorshift_state_t
    return xorshift_state_t
}

/// Generate random Double value from [0, 1].
func randUniform() -> Double {
    return Double(xorshift64bit()) / Double(UInt64.max)
}

/// Generate random Int value.
/// Excludes `upperBound`.
func randint(_ upperBound: Int) -> Int {
    return Int(xorshift64bit() % UInt64(upperBound))
}

extension Array {
    
    /// Pick one element with even odds.
    public func randomPick() -> Element? {
        guard count > 0 else {
            return nil
        }
        let index = randint(count)
        return self[index]
    }
    
    /// Pick one element.
    /// - Parameter odds: The probabilities associated with each element.
    /// - Warning: Small odds may cause computation error. Use `randomPick(cumulativeOdds:)` or `randomPick(weights:)` instead.
    public func randomPick(by odds: [Double]) -> Element? {
        precondition(odds.count == count, "`odds` size must match with array size.")
        
        guard count > 0 else {
            return nil
        }
        
        let r = randUniform()
        
        var acc: Double = 0
        for i in 0..<odds.count {
            acc += odds[i]
            if acc >= r {
                return self[i]
            }
        }
        fatalError("No elements picked. Maybe sum of `odds`(\(acc)) < 1.")
    }
    
    /// Pick one element.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    public func randomPick(cumulativeWeights: [Double]) -> Element? {
        precondition(cumulativeWeights.count == count, "`cumulativeWeights` size must match with array size.")
        precondition(zip(cumulativeWeights, cumulativeWeights.dropFirst()).all { $0 <= $1 },
                     "`cumulativeWeights` is not ascending.")
        
        guard count > 0 else {
            return nil
        }
        
        let r = randUniform() * cumulativeWeights.last!
        let index = cumulativeWeights.index { $0 > r }!
        return self[index]
    }
    
    /// Pick one element.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    public func randomPick(weights: [Int]) -> Element? {
        precondition(weights.count == count, "`weights` size must match with array size.")
        
        guard count > 0 else {
            return nil
        }
        
        let weightSum = weights.sum()!
        let r = randint(weightSum)
        var acc = 0
        for i in 0..<weights.count {
            acc += weights[i]
            if r < acc {
                return self[i]
            }
        }
        preconditionFailure("No elements picked.")
    }
}

extension Array {
    /// Shuffle array.
    public mutating func shuffle() {
        precondition(count <= UInt32.max, "Humongous arrays are not supported.")
        
        for i in (0..<count).reversed() {
            let r = randint(i+1)
            let temp = self[i]
            self[i] = self[r]
            self[r] = temp
        }
    }
    
    /// Shuffle array.
    public func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }
}
