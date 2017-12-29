
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
    
    /// Returns the indices that would sort an array.
    public func argsort(by areInIncreasingOrder: (Element, Element)->Bool) -> [Int] {
        let sorted = self.enumerated().sorted { areInIncreasingOrder($0.1, $1.1) }
        return sorted.map { $0.0 }
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

extension Array where Element: Comparable {
    /// Returns the indices that would sort an array.
    public func argsort() -> [Int] {
        return argsort(by: <)
    }
    
    /// Returns k-th smallest element.
    public func quickSelect(k: Int) -> Element {
        precondition(k < count, "Index out of ramge.")
        var array = self
        
        var left = 0
        var right = array.count
        
        while true {
            if left == k && right == k+1 {
                return array[k]
            }
            
            var l = left
            var r = right - 1
            
            var sep: Int = -1
            
            // pick pivot randomly
            let pivotIndex = randint(right - left) + left
            let pivot = array[pivotIndex]
            
            while true {
                while array[l] < pivot {
                    l += 1
                    if l == r {
                        sep = l
                        break
                    }
                }
                while array[r] >= pivot && l != r {
                    r -= 1
                    if l == r {
                        sep = l
                        break
                    }
                }
                if l == r {
                    break
                }
                
                let temp = array[l]
                array[l] = array[r]
                array[r] = temp
            }
            
            // For all i < sep, array[i] < pivot
            if k < sep {
                right = sep
            } else {
                left = sep
            }
        }
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
