
extension Array {
    /// Returns the indices that would sort an array.
    public func argsort(by areInIncreasingOrder: (Element, Element) throws ->Bool) rethrows -> [Int] {
        let sorted = try self.enumerated().sorted { try areInIncreasingOrder($0.element, $1.element) }
        return sorted.map { $0.offset }
    }
    
    /// Returns stably sorted array.
    public func stableSorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element] {
        let sorted = try self.enumerated().sorted {
            if try areInIncreasingOrder($0.element, $1.element) {
                return true
            } else if try areInIncreasingOrder($1.element, $0.element) {
                return false
            } else {
                return $0.offset < $1.offset
            }
        }
        return sorted.map { $0.element }
    }
}

extension Array where Element: Comparable {
    /// Returns the indices that would sort an array.
    public func argsort() -> [Int] {
        return argsort(by: <)
    }
    
    /// Returns stably sorted array.
    public func stableSorted() -> [Element] {
        let sorted = self.enumerated().sorted {
            if $0.element < $1.element {
                return true
            } else if $1.element < $0.element {
                return false
            } else {
                return $0.offset < $1.offset
            }
        }
        return sorted.map { $0.element }
    }
}
