extension Array {
    /// Separates array into `sections` slices.
    /// - Parameters:
    ///   - sections: Number of sections the array will be splited into.
    ///   - omittingEmptySlices: If `true`, return array won't contain empty slices. Default is `true`.
    public func split(_ sections: Int, includesEmptySlices: Bool = false) -> [ArraySlice<Element>] {
        guard count >= sections else {
            if includesEmptySlices {
                return (0..<count).map { self[$0..<$0+1] } + (count..<sections).map { _ in ArraySlice() }
            } else {
                return (0..<count).map { self[$0..<$0+1] }
            }
        }
        
        let minSectionSize = self.count / sections
        let plusOnes = self.count % sections
        
        var result = [ArraySlice<Element>]()
        result.reserveCapacity(sections)
        
        var l = 0
        for _ in 0..<plusOnes {
            let slice = self[l..<l+minSectionSize + 1]
            result.append(slice)
            l += minSectionSize + 1
        }
        for _ in plusOnes..<sections {
            let slice = self[l..<l+minSectionSize]
            result.append(slice)
            l += minSectionSize
        }
        return result
    }
    
    /// Separates array into slices of `size`.
    /// Note: If `count % size != 0`, last slice has fewer elements.
    public func chunk(_ size: Int) -> [ArraySlice<Element>] {
        var result = [ArraySlice<Element>]()
        result.reserveCapacity(count/size)
        
        let tail = count%size
        
        for i in stride(from: 0, to: count-tail, by: size) {
            result.append(self[i..<i+size])
        }
        
        if tail > 0 {
            result.append(self[(count-tail)...])
        }
        
        return result
    }
}
