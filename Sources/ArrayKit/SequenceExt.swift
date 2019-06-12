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
