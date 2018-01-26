
extension RandomAccessCollection {
    /// Returns the indices that would sort an array.
    public func argsort(by areInIncreasingOrder: (Element, Element) throws ->Bool) rethrows -> [Index] {
        let sorted = try zip(self, indices).sorted { try areInIncreasingOrder($0.0, $1.0) }
        return sorted.map { $0.1 }
    }
}

extension RandomAccessCollection where Element: Comparable {
    /// Returns the indices that would sort an array.
    public func argsort() -> [Index] {
        return argsort(by: <)
    }
}

extension RandomAccessCollection {
    /// Returns stably sorted array.
    public func stableSorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element] {
        let sorted = try zip(self, indices).sorted {
            if try areInIncreasingOrder($0.0, $1.0) {
                return true
            } else if try areInIncreasingOrder($1.0, $0.0) {
                return false
            } else {
                return $0.1 < $1.1
            }
        }
        return sorted.map { $0.0 }
    }
}

extension RandomAccessCollection where Element: Comparable {
    /// Returns stably sorted array.
    public func stableSorted() -> [Element] {
        return stableSorted(by: <)
    }
}
