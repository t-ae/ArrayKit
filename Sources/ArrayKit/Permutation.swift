
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
    /// Performs left rotation.
    public mutating func rotate(n: Int) {
        var n = n % count
        if n < 0 {
            n += count
        }
        for i in 0..<count-n {
            let temp = self[i]
            self[i] = self[i + n]
            self[i+n] = temp
        }
    }
    
    /// Performs left rotation
    public func rotated(n: Int) -> Array {
        var n = n % count
        if n < 0 {
            n += count
        }
        return Array(self[n...] + self[..<n])
    }
}
