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
}

extension Array {
    /// Left rotates `n` times.
    public mutating func rotate(n: Int) {
        self = rotated(n: n)
    }
    
    /// Returns the array left rotated `n` times.
    public func rotated(n: Int) -> Array {
        var n = n % count
        if n < 0 {
            n += count
        }
        return Array(self[n...] + self[..<n])
    }
}
