extension Collection {
    /// Returns the index of minimum element.
    /// If `array` has multiple minimums, the earliest index will be returned.
    public func argmin(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Index? {
        var iterator = indices.makeIterator()
        guard var index = iterator.next() else {
            return nil
        }
        var currentMin = self[index]
        
        while let i = iterator.next() {
            let v = self[i]
            if try areInIncreasingOrder(v, currentMin) {
                currentMin = v
                index = i
            }
        }
        
        return index
    }
    
    /// Returns the index of maximum element.
    /// If `array` has multiple maximums, the earliest index will be returned.
    public func argmax(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Index? {
        var iterator = indices.makeIterator()
        guard var index = iterator.next() else {
            return nil
        }
        var currentMax = self[index]
        
        while let i = iterator.next() {
            let v = self[i]
            if try areInIncreasingOrder(currentMax, v) {
                currentMax = v
                index = i
            }
        }
        
        return index
    }
}

extension Collection where Element: Comparable {
    
    /// Returns the index of minimum element.
    /// If `array` has multiple minimums, the earliest index will be returned.
    public func argmin() -> Index? {
        return argmin(by: <)
    }
    
    /// Returns the index of maximum element.
    /// If `array` has multiple maximums, the earliest index will be returned.
    public func argmax() -> Index? {
        return argmax(by: <)
    }
}
