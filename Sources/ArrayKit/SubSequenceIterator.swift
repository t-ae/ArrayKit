
public struct SubSequenceIterator<SequenceElement>: Sequence, IteratorProtocol {
    let array: [SequenceElement]
    var lengthIterator: IndexingIterator<CountableRange<Int>>
    
    var index: Int
    var length: Int?
    
    init(array: [SequenceElement], length: CountableRange<Int>) {
        self.array = array
        self.lengthIterator = length.makeIterator()
        self.index = 0
        self.length = self.lengthIterator.next()
    }
    
    public mutating func next() -> ArraySlice<SequenceElement>? {
        guard let length = self.length, length <= array.count else {
            return nil
        }
        
        defer {
            self.index += 1
            
            if length == 0 || index + length > array.count {
                self.length = lengthIterator.next()
                index = 0
            }
        }
        
        return array[index..<index+length]
    }
}

extension Array {
    /// Sequence of all sub sequences.
    public func subSequences() -> SubSequenceIterator<Element> {
        return .init(array: self, length: 0..<self.count+1)
    }
    
    /// Sequence of all sub sequences of specified `length`.
    public func subSequences(of length: Int) -> SubSequenceIterator<Element> {
        return .init(array: self, length: length..<length+1)
    }
}
