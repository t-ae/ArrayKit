
extension Sequence {
    /// Checks if all elements satisfy `predicate`.
    public func all(_ predicate: (Element)->Bool) -> Bool {
        for e in self {
            if !predicate(e) {
                return false
            }
        }
        return true
    }
    
    /// Checks if one or more elements satisfy `predicate`.
    public func some(_ predicate: (Element)->Bool) -> Bool {
        for e in self {
            if predicate(e) {
                return true
            }
        }
        return false
    }
}


extension Sequence {
    /// Returns a list of successive reduced values.
    public func scan<Result>(_ initialResult: Result, _ nextResult: (Result, Element)->Result) -> [Result] {
        var result = [Result]()
        
        var acc = initialResult
        for e in self {
            acc = nextResult(acc, e)
            result.append(acc)
        }
        
        return result
    }
}
