
extension Array {
    /// Permute elements by `order`.
    public func permuted(by order: [Int]) -> Array {
        precondition(Set(order) == Set(0..<count), "`order` is not valid permutation.")
        
        return order.map { self[$0] }
    }
    
    /// Permute elements by `order`.
    public mutating func permute(by order: [Int]) {
        self = permuted(by: order)
    }
    
    /// Returns a list of successive reduced values.
    public func scan<Result>(_ initialResult: Result, _ nextResult: (Result, Element)->Result) -> [Result] {
        
        var result = [Result]()
        result.reserveCapacity(count)
        
        var acc = initialResult
        for e in self {
            acc = nextResult(acc, e)
            result.append(acc)
        }
        
        return result
    }
    
    /// Returns the indices that would sort an array.
    public func argsort(by areInIncreasingOrder: (Element, Element)->Bool) -> [Int] {
        let sorted = self.enumerated().sorted { areInIncreasingOrder($0.1, $1.1) }
        return sorted.map { $0.0 }
    }
    
    /// Rotate array.
    public mutating func rotate(n: Int) {
        // TODO: In-place version is better?
        self = rotated(n: n)
    }
    
    /// Rotate array.
    public func rotated(n: Int) -> Array {
        var n = n % count
        if n < 0 {
            n += count
        }
        return Array(self[n...] + self[..<n])
    }
}

extension Array where Element: Comparable {
    /// Returns the indices that would sort an array.
    public func argsort() -> [Int] {
        return argsort(by: <)
    }
}

extension Array {
    /// Drop elements which corresponding `mask` value is `false`.
    public mutating func mask(with mask: [Bool]) {
        precondition(mask.count == count, "`mask` is not valid permutation.")
        for i in (0..<count).reversed() {
            if !mask[i] {
                self.remove(at: i)
            }
        }
    }
    
    /// Drop elements which corresponding `mask` value is `false`.
    public func masked(with mask: [Bool]) -> Array {
        var result = self
        result.mask(with: mask)
        return result
    }
}
