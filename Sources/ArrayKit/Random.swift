import Foundation

// MARK: - Single element
extension Array {
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElement<F: BinaryFloatingPoint, G: RandomNumberGenerator>(cumulativeWeights: [F],
                                                                                using generator: inout G) -> Element?
        where F.RawSignificand : FixedWidthInteger {
            precondition(cumulativeWeights.count == count, "`cumulativeWeights` size must match with array size.")
            
            guard count > 0 else {
                return nil
            }
            
            precondition(cumulativeWeights.first! >= 0, "`cumulativeWeights` must start with positive value.")
            precondition(zip(cumulativeWeights, cumulativeWeights.dropFirst()).allSatisfy { $0 <= $1 },
                         "`cumulativeWeights` is not ascending.")
            
            let r = F.random(in: 0..<cumulativeWeights.last!, using: &generator)
            let index = cumulativeWeights.firstIndex { $0 > r }!
            return self[index]
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - cumulativeWeights: The cumulative weights associated with each element.
    public func randomElement<F: BinaryFloatingPoint>(cumulativeWeights: [F]) -> Element?
        where F.RawSignificand : FixedWidthInteger {
            var g = SystemRandomNumberGenerator()
            return randomElement(cumulativeWeights: cumulativeWeights, using: &g)
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElement<F: BinaryFloatingPoint, G: RandomNumberGenerator>(weights: [F],
                                                                                using generator: inout G) -> Element?
        where F.RawSignificand : FixedWidthInteger {
            let cumulative = weights.scan(0, { $0 + $1 })
            return randomElement(cumulativeWeights: cumulative, using: &generator)
    }
    
    /// Returns a random element with weighted odds.
    /// - Paramter:
    ///   - weights: The weights associated with each element.
    public func randomElement<F: BinaryFloatingPoint>(weights: [F]) -> Element?
        where F.RawSignificand : FixedWidthInteger {
            var g = SystemRandomNumberGenerator()
            return randomElement(weights: weights, using: &g)
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
        var g = SystemRandomNumberGenerator()
        return randomElement(weights: weights, using: &g)
    }
}

// MARK: - Multiple elements
extension Array {
    /// Returns distinct `n` elements.
    ///
    /// The order of result is stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElements<G: RandomNumberGenerator>(n: Int, using generator: inout G) -> [Element]? {
        return randomElements(n: n, weights: [Double](repeating: 1, count: count), using: &generator)
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    public func randomElements(n: Int) -> [Element]? {
        var g = SystemRandomNumberGenerator()
        return randomElements(n: n, weights: [Double](repeating: 1, count: count), using: &g)
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - weights: The weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElements<F: BinaryFloatingPoint, G: RandomNumberGenerator>(n: Int,
                                                                                 weights: [F],
                                                                                 using generator: inout G) -> [Element]?
        where F.RawSignificand : FixedWidthInteger {
            precondition(weights.count == count, "`odds` size must match with array size.")
            precondition(n >= 0, "`n` must be positive.")
            precondition(weights.allSatisfy { $0 >= 0 }, "All elements of `weights` must be positive.")
            precondition(weights.contains { $0 > 0 }, "All elements of `weights` are 0.")
            
            guard n <= count else {
                return nil
            }
            
            var weights = weights
            var resultIndices = [Int]()
            resultIndices.reserveCapacity(n)
            for _ in 0..<n {
                let cumulativeWeights = weights.scan(0, +)
                let r = F.random(in: 0..<cumulativeWeights.last!, using: &generator)
                let i = cumulativeWeights.firstIndex { r <= $0 }!
                weights[i] = 0 // won't select again
                resultIndices.append(i)
            }
            return resultIndices.map { self[$0] }
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - weights: The weights associated with each element.
    ///   - generator: RandomNumberGenerator to use.
    public func randomElements<F: BinaryFloatingPoint>(n: Int,
                                                       weights: [F]) -> [Element]?
        where F.RawSignificand : FixedWidthInteger {
            var g = SystemRandomNumberGenerator()
            return randomElements(n: n, weights: weights, using: &g)
    }
    
    /// Returns distinct `n` elements.
    ///
    /// The order of result is stable.
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
    /// The order of result is stable.
    ///
    /// - Parameters:
    ///   - n: Number of elements to return.
    ///   - weights: The probabilities associated with each element.
    public func randomElements(n: Int,
                               weights: [Int]) -> [Element]? {
        var g = SystemRandomNumberGenerator()
        return randomElements(n: n, weights: weights, using: &g)
    }
}

// MARK: - Range or slice
extension Array {
    /// Generate slice randomly with even odds.
    /// - Parameters:
    ///   - includesEmpty: If true, generated slice can be empty. Default is `false`.
    ///   - generator: RandomNumberGenerator to use.
    public func randomSlice<G: RandomNumberGenerator>(includesEmpty: Bool = false,
                                                      using generator: inout G) -> ArraySlice<Element> {
        return self[randomRange(includesEmpty: includesEmpty, using: &generator)]
    }
    
    /// Generate slice randomly with even odds.
    /// - Parameters:
    ///   - includesEmpty: If true, generated slice can be empty. Default is `false`.
    public func randomSlice(includesEmpty: Bool = false) -> ArraySlice<Element> {
        var g = SystemRandomNumberGenerator()
        return randomSlice(includesEmpty: includesEmpty, using: &g)
    }
    
    /// Generate random range in array.
    /// - Parameters:
    ///   - includesEmpty: If true, generated range can be empty. Default is `false`.
    ///   - generator: RandomNumberGenerator to use.
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
    public func randomRange(includesEmpty: Bool = false) -> CountableRange<Int> {
        var g = SystemRandomNumberGenerator()
        return randomRange(includesEmpty: includesEmpty, using: &g)
    }
}
