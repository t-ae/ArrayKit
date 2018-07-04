
import Foundation

// MARK: - Utilities

// MARK: - Single element
extension Array {
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElement<F: BinaryFloatingPoint, G: RandomNumberGenerator>(cumulativeWeights: [F],
                                                                                using generator: inout G) -> Element?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
            precondition(cumulativeWeights.count == count, "`cumulativeWeights` size must match with array size.")
            
            guard count > 0 else {
                return nil
            }
            
            precondition(cumulativeWeights.first! >= 0, "`cumulativeWeights` must start with positive value.")
            precondition(zip(cumulativeWeights, cumulativeWeights.dropFirst()).all { $0 <= $1 },
                         "`cumulativeWeights` is not ascending.")
            
            let r = F.random(in: 0..<cumulativeWeights.last!, using: &generator)
            let index = cumulativeWeights.index { $0 > r }!
            return self[index]
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    public func randomElement<F: BinaryFloatingPoint>(cumulativeWeights: [F]) -> Element?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
            return randomElement(cumulativeWeights: cumulativeWeights, using: &Random.default)
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElement<F: BinaryFloatingPoint, G: RandomNumberGenerator>(weights: [F],
                                                                                using generator: inout G) -> Element?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
            let cumulative = weights.scan(0, { $0 + $1 })
            return randomElement(cumulativeWeights: cumulative, using: &generator)
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    public func randomElement<F: BinaryFloatingPoint>(weights: [F]) -> Element?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger{
            return randomElement(weights: weights, using: &Random.default)
    }
    
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElement<G: RandomNumberGenerator>(weights: [Int],
                                                        using generator: inout G) -> Element? {
        return randomElement(weights: weights.map(Double.init), using: &generator)
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    public func randomElement(weights: [Int]) -> Element? {
        return randomElement(weights: weights, using: &Random.default)
    }
}

// MARK: - Multiple elements
extension Array {
    /// Returns distinct `n` elements.
    ///
    /// The order of result is not stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElements<G: RandomNumberGenerator>(n: Int, using generator: inout G) -> [Element]? {
        return randomElements(n: n, weights: [Double](repeating: 1, count: count), using: &generator)
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is not stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    public func randomElements(n: Int) -> [Element]? {
        return randomElements(n: n, weights: [Double](repeating: 1, count: count), using: &Random.default)
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is not stable, and elements with high odds tend to appear earlier in result.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - weights: The weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElements<F: BinaryFloatingPoint, G: RandomNumberGenerator>(n: Int,
                                                                                 weights: [F],
                                                                                 using generator: inout G) -> [Element]?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
            precondition(weights.count == count, "`odds` size must match with array size.")
            precondition(n >= 0, "`n` must be positive.")
            precondition(weights.all { $0 >= 0 }, "All elements of `weights` must be positive.")
            precondition(weights.some { $0 > 0 }, "All elements of `weights` are 0.")
            
            guard n <= count else {
                return nil
            }
            
            var weights = weights
            var rest = self
            var result = [Element]()
            result.reserveCapacity(n)
            for _ in 0..<n {
                let cumulativeWeights = weights.scan(0, +)
                let r = F.random(in: 0..<cumulativeWeights.last!, using: &generator)
                let i = cumulativeWeights.index { r <= $0 }!
                weights.remove(at: i)
                let e = rest.remove(at: i)
                result.append(e)
            }
            return result
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is not stable, and elements with high odds tend to appear earlier in result.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - weights: The weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElements<F: BinaryFloatingPoint>(n: Int,
                                                       weights: [F]) -> [Element]?
        where F.RawSignificand : FixedWidthInteger,
        F.RawSignificand.Stride : SignedInteger,
        F.RawSignificand.Magnitude : UnsignedInteger {
            return randomElements(n: n, weights: weights, using: &Random.default)
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is not stable, and large weight elements tend to appear earlier in result.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - weights: The probabilities associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElements<G: RandomNumberGenerator>(n: Int,
                                                         weights: [Int],
                                                         using generator: inout G) -> [Element]? {
        return randomElements(n: n, weights: weights.map(Double.init), using: &generator)
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is not stable, and large weight elements tend to appear earlier in result.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - weights: The probabilities associated with each element.
    public func randomElements(n: Int,
                               weights: [Int]) -> [Element]? {
        return randomElements(n: n, weights: weights, using: &Random.default)
    }
}

// MARK: - Generate range or slice
extension Array {
    /// Generate slice randomly with even odds.
    /// - Parameters:
    ///   - includesEmpty: If true, generated slice can be empty. Default is `false`.
    ///   - using: RandomNumberGenerator to use.
    public func randomSlice<G: RandomNumberGenerator>(includesEmpty: Bool = false,
                                                      using generator: inout G) -> ArraySlice<Element> {
        return self[randomRange(includesEmpty: includesEmpty, using: &generator)]
    }
    
    /// Generate slice randomly with even odds.
    /// - Parameters:
    ///   - includesEmpty: If true, generated slice can be empty. Default is `false`.
    public func randomSlice(includesEmpty: Bool = false) -> ArraySlice<Element> {
        return randomSlice(includesEmpty: includesEmpty, using: &Random.default)
    }
    
    /// Generate random range in array.
    /// - Parameters:
    ///   - includesEmpty: If true, generated range can be empty. Default is `false`.
    ///   - using: RandomNumberGenerator to use.
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
    
    /// Generate random range in array.
    /// - Parameters:
    ///   - includesEmpty: If true, generated range can be empty. Default is `false`.
    ///   - using: RandomNumberGenerator to use.
    public func randomRange(includesEmpty: Bool = false) -> CountableRange<Int> {
        return randomRange(includesEmpty: includesEmpty, using: &Random.default)
    }
}
