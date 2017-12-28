
public struct CombinaionSequence<Element>: Sequence {
    let array: [Element]
    let k: Int
    
    public func makeIterator() -> CombinationIterator<Element> {
        return CombinationIterator(array: array, k: k)
    }
}

public struct CombinationIterator<SetElement>: IteratorProtocol {
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
            if indices[i] >= array.count - k + i + 1 {
                guard let p = increment(i-1) else {
                    return nil
                }
                indices[i] = p+1
            }
            return indices[i]
        }
        guard increment(k-1) != nil else {
            return nil
        }
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
    public func combinations(k: Int) -> CombinaionSequence<Element> {
        return CombinaionSequence(array: self, k: k)
    }
}
