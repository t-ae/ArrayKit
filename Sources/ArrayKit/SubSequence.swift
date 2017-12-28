
public struct SubSequenceSequence<Element>: Sequence {
    let array: [Element]
    let length: CountableRange<Int>
    
    public func makeIterator() -> SubSequenceIterator<Element> {
        return SubSequenceIterator(array: array, length: length)
    }
}

public struct SubSequenceIterator<SequenceElement>: IteratorProtocol {
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
        
        let slice = array[index..<index+length]
        
        self.index += 1
        
        if length == 0 || index + length > array.count {
            self.length = lengthIterator.next()
            index = 0
        }
        
        return slice
    }
}

extension Array {
    /// Sequence of all sub sequences.
    public func subSequences() -> SubSequenceSequence<Element> {
        return SubSequenceSequence(array: self, length: 0..<self.count+1)
    }
    
    /// Sequence of all sub sequences of specified `length`.
    public func subSequences(of length: Int) -> SubSequenceSequence<Element> {
        return SubSequenceSequence(array: self, length: length..<length+1)
    }
}
