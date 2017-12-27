
extension Array {
    public func permuted(by order: [Int]) -> Array {
        precondition(Set(order) == Set(0..<count), "`order` is not valid permutation.")
        
        return order.map { self[$0] }
    }
    
    public mutating func permute(by order: [Int]) {
        self = permuted(by: order)
    }
    
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
    
    public func argsort(by areInIncreasingOrder: (Element, Element)->Bool) -> [Int] {
        let sorted = self.enumerated().sorted { areInIncreasingOrder($0.1, $1.1) }
        return sorted.map { $0.0 }
    }
}

extension Array where Element: Comparable {
    public func argsort() -> [Int] {
        return argsort(by: <)
    }
}

extension Array {
    public mutating func mask(by mask: [Bool]) {
        precondition(mask.count == count, "`mask` is not valid permutation.")
        for i in (0..<count).reversed() {
            if !mask[i] {
                self.remove(at: i)
            }
        }
    }
    
    public func masked(by mask: [Bool]) -> Array {
        var result = self
        result.mask(by: mask)
        return result
    }
}
