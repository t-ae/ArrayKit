
extension Array where Element: Comparable {
    /// Returns k-th smallest element.
    ///
    /// This method doesn't consider exceptional values(like FloatingPoint.nan).
    /// Remove them before use this method.
    public func quickSelect(k: Int) -> Element {
        precondition(k < count, "Index out of ramge.")
        var slice = ArraySlice(self)
        
        while true {
            let pivotIndex = randint(slice.endIndex - slice.startIndex) + slice.startIndex
            let pivot = slice[pivotIndex]
            
            slice.swapAt(pivotIndex, slice.endIndex-1)
            let rightStart = slice.partition(by: { $0 >= pivot })
            slice.swapAt(rightStart, slice.endIndex-1)
            
            if k == rightStart {
                return slice[k]
            } else if k < rightStart {
                slice = slice[..<rightStart]
            } else {
                slice = slice[(rightStart+1)...]
            }
        }
    }
}
