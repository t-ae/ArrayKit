
extension Array {
    /// Permutes elements by `order`.
    public func permuted(by order: [Int]) -> Array {
        precondition(Set(order) == Set(0..<count), "`order` is not valid permutation.")
        
        return order.map { self[$0] }
    }
    
    /// Permutes elements by `order`.
    public mutating func permute(by order: [Int]) {
        self = permuted(by: order)
    }
    
    /// Rotates array.
    public mutating func rotate(n: Int) {
        // TODO: In-place version is better?
        self = rotated(n: n)
    }
    
    /// Rotates array.
    public func rotated(n: Int) -> Array {
        var n = n % count
        if n < 0 {
            n += count
        }
        return Array(self[n...] + self[..<n])
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
