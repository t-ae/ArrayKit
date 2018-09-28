/// Negation.
public prefix func ~(array: [Bool]) -> [Bool] {
    return array.map { !$0 }
}

/// Logical conjunction.
public func &(lhs: [Bool], rhs: [Bool]) -> [Bool] {
    precondition(lhs.count == rhs.count)
    var result = lhs
    for i in 0..<result.count {
        result[i] = result[i] && rhs[i]
    }
    return result
}

/// Logical disjunction.
public func |(lhs: [Bool], rhs: [Bool]) -> [Bool] {
    precondition(lhs.count == rhs.count)
    var result = lhs
    for i in 0..<result.count {
        result[i] = result[i] || rhs[i]
    }
    return result
}

/// Logical exclusive disjunction.
public func ^(lhs: [Bool], rhs: [Bool]) -> [Bool] {
    precondition(lhs.count == rhs.count)
    var result = lhs
    for i in 0..<result.count {
        result[i] = result[i] != rhs[i]
    }
    return result
}

extension Array where Element == Bool {
    
    /// Makes random mask array.
    /// i-th element becomes `true` with the probability `odds[i]`.
    public static func makeRandomMask<F: BinaryFloatingPoint, G: RandomNumberGenerator>(odds: [F],
                                                                                        using generator: inout G) -> [Bool]
        where F.RawSignificand : FixedWidthInteger {
            var result = [Bool](repeating: false, count: odds.count)
            
            for i in 0..<odds.count {
                let r = F.random(in: 0..<1, using: &generator)
                result[i] = r < odds[i]
            }
            
            return result
    }
    
    /// Makes random mask array.
    /// i-th element becomes `true` with the probability `odds[i]`.
    public static func makeRandomMask<F: BinaryFloatingPoint>(odds: [F]) -> [Bool]
        where F.RawSignificand : FixedWidthInteger {
            var g = SystemRandomNumberGenerator()
            return makeRandomMask(odds: odds, using: &g)
    }
    
    /// Makes random mask array.
    /// Each element becomes `true` with the probability `odds`.
    public static func makeRandomMask<F: BinaryFloatingPoint, G: RandomNumberGenerator>(odds: F,
                                                                                        count: Int,
                                                                                        using generator: inout G) -> [Bool]
        where F.RawSignificand : FixedWidthInteger {
        var result = [Bool](repeating: false, count: count)
        
        for i in 0..<count {
            let r = F.random(in: 0..<1, using: &generator)
            result[i] = r < odds
        }
        
        return result
    }
    
    /// Makes random mask array.
    /// Each element becomes `true` with the probability `odds`.
    public static func makeRandomMask<F: BinaryFloatingPoint>(odds: F,
                                                              count: Int) -> [Bool]
        where F.RawSignificand : FixedWidthInteger {
            var g = SystemRandomNumberGenerator()
            return makeRandomMask(odds: odds, count: count, using: &g)
    }
}

extension Array {
    /// Drops elements which corresponding `mask` value is `false`.
    public mutating func mask(with mask: [Bool]) {
        precondition(mask.count == count, "`mask` is not valid permutation.")
        for i in (0..<count).reversed() {
            if !mask[i] {
                self.remove(at: i)
            }
        }
    }
    
    /// Drops elements which corresponding `mask` value is `false`.
    public func masked(with mask: [Bool]) -> Array {
        var result = self
        result.mask(with: mask)
        return result
    }
}
