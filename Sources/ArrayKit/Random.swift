
import Foundation

// MARK: - Utilities

// MARK: - Pick single element
extension Array {
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    ///   - using: RandomNumberGenerator to use.
    public func randomPick<F: BinaryFloatingPoint, G: RandomNumberGenerator>(cumulativeWeights: [F],
                                                                             using generator: inout G) -> Element?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
            precondition(cumulativeWeights.count == count, "`cumulativeWeights` size must match with array size.")
            precondition(zip(cumulativeWeights, cumulativeWeights.dropFirst()).all { $0 <= $1 },
                         "`cumulativeWeights` is not ascending.")
            
            guard count > 0 else {
                return nil
            }
            
            precondition(cumulativeWeights.first! >= 0, "`cumulativeWeights` must start with positive value.")
            
            let r = F.random(in: 0..<cumulativeWeights.last!, using: &generator)
            let index = cumulativeWeights.index { $0 > r }!
            return self[index]
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    public func randomPick<F: BinaryFloatingPoint>(cumulativeWeights: [F]) -> Element?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
            return randomPick(cumulativeWeights: cumulativeWeights, using: &Random.default)
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    ///   - using: RandomNumberGenerator to use.
    public func randomPick<G: RandomNumberGenerator>(weights: [Int],
                                                     using generator: inout G) -> Element? {
        precondition(weights.count == count, "`weights` size must match with array size.")
        precondition(weights.all { $0 >= 0 }, "All `weights` must be positive.")
        
        guard count > 0 else {
            return nil
        }
        
        precondition(weights.some { $0 > 0 }, "Can't pick because all `weights` are 0.")
        
        let weightSum = weights.sum()!
        let r = Int.random(in: 0..<weightSum, using: &generator)
        var acc = 0
        for i in 0..<weights.count {
            acc += weights[i]
            if r < acc {
                return self[i]
            }
        }
        fatalError("No elements picked.")
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    public func randomPick(weights: [Int]) -> Element? {
        return randomPick(weights: weights, using: &Random.default)
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
    public func randomPick<G: RandomNumberGenerator>(n: Int, using generaor: inout G) -> [Element]? {
        precondition(n >= 0, "`n` must be positive.")
        guard n <= count else {
            return nil
        }
        
        var result = [Element]()
        result.reserveCapacity(n)
        
        var rest = self
        for _ in 0..<n {
            let i = Int.random(in: 0..<rest.count)
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
    public func randomPick<F: BinaryFloatingPoint, G: RandomNumberGenerator>(n: Int,
                                                                             by odds: [F],
                                                                             using generator: inout G) -> [Element]?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
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
                let r = F.random(in: 0..<cumulativeOdds.last!, using: &generator)
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
    public func randomPick<G: RandomNumberGenerator>(n: Int, weights: [Int], using generator: inout G) -> [Element]? {
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
            let r = Int.random(in: 0..<weightsSum, using: &generator)
            
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
    public func randomSlice<G: RandomNumberGenerator>(includesEmpty: Bool = false,
                                                      using generator: inout G) -> ArraySlice<Element> {
        return self[randomRange(includesEmpty: includesEmpty, using: &generator)]
    }
    
    /// Generate random range in array.
    /// - Parameters:
    ///   - includesEmpty: If true, generated range can be empty. Default is `false`.
    public func randomRange<G: RandomNumberGenerator>(includesEmpty: Bool = false,
                                                      using generator: inout G) -> CountableRange<Int> {
        var number: Int
        if includesEmpty {
            number = Int.random(in: 0..<count*(1+count)/2 + 1, using: &generator) - 1
        } else {
            number = Int.random(in: 0..<count*(1+count)/2, using: &generator)
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
