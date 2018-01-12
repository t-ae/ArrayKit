
public struct PermutationIterator<SetElement>: Sequence, IteratorProtocol {
    let array: [SetElement]
    let k: Int
    
    var indices: [Int]?
    
    init(array: [SetElement], k: Int) {
        precondition(k >= 0, "`k` must be positive.")
        
        self.array = array
        self.k = k
        if k <= array.count {
            self.indices = [Int](0..<k)
        } else {
            self.indices = nil
        }
    }
    
    func nextIndices(_ indices: [Int]) -> [Int]? {
        var indices = indices
        func increment(_ i: Int) -> Int? {
            guard i >= 0 else {
                return nil
            }
            indices[i] += 1
            if indices[i] >= array.count {
                guard let _ = increment(i-1) else {
                    return nil
                }
                indices[i] = 0
            }
            return indices[i]
        }
        
        // skip while `indices` contains duplications.
        repeat {
            guard increment(k-1) != nil else {
                return nil
            }
        } while Set(indices).count != indices.count
        
        return indices
    }
    
    public mutating func next() -> [SetElement]? {
        guard let indices = self.indices else {
            return nil
        }
        let current = indices.map { array[$0] }
        
        self.indices = nextIndices(indices)
        
        return current
    }
}

extension Array {
    /// Sequence of all permutations of elements.
    public func permutations() -> PermutationIterator<Element> {
        return .init(array: self, k: self.count)
    }
    
    /// Sequence of all permutations of `k` elements.
    public func permutations(k: Int) -> PermutationIterator<Element> {
        return .init(array: self, k: k)
    }
}
