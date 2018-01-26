
extension Array where Element: Comparable {
    
    /// Returns the index of minimum element.
    /// If `array` has multiple minimums, the earliest index will be returned.
    public func argmin(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Int? {
        var iterator = enumerated().makeIterator()
        guard var (index, currentMin) = iterator.next() else {
            return nil
        }
        
        while let (i, v) = iterator.next() {
            if try areInIncreasingOrder(v, currentMin) {
                currentMin = v
                index = i
            }
        }
        
        return index
    }
    
    /// Returns the index of minimum element.
    /// If `array` has multiple minimums, the earliest index will be returned.
    public func argmin() -> Int? {
        return argmin(by: <)
    }
    
    /// Returns the index of maximum element.
    /// If `array` has multiple maximums, the earliest index will be returned.
    public func argmax(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Int? {
        var iterator = enumerated().makeIterator()
        guard var (index, currentMax) = iterator.next() else {
            return nil
        }
        
        while let (i, v) = iterator.next() {
            if try areInIncreasingOrder(currentMax, v) {
                currentMax = v
                index = i
            }
        }
        
        return index
    }
    
    /// Returns the index of maximum element.
    /// If `array` has multiple maximums, the earliest index will be returned.
    public func argmax() -> Int? {
        return argmax(by: <)
    }
}
