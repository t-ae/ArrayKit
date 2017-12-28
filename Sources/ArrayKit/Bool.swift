
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
    
    /// Make random mask array.
    /// i-th element becomes `true` with the probability `odds[i]`.
    public static func makeRandomMask(odds: [Double]) -> [Bool] {
        var result = [Bool]()
        result.reserveCapacity(odds.count)
        
        for o in odds {
            let r = randUniform()
            result.append(r < o)
        }
        
        return result
    }
    
    /// Make random mask array.
    /// Each element becomes `true` with the probability `odds`.
    public static func makeRandomMask(odds: Double, count: Int) -> [Bool] {
        var result = [Bool]()
        result.reserveCapacity(count)
        
        for _ in 0..<count {
            let r = randUniform()
            result.append(r < odds)
        }
        
        return result
    }
}
