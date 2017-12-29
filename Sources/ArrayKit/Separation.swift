
extension Array {
    /// Separates array into `sections` slices.
    /// If `count < sections`, return array contains `count` single element slices.
    /// - Parameters:
    ///   - sections: Number of sections the array will be splited into.
    ///   - omittingEmptySlices: If `true`, return array won't contain empty slices.
    public func split(_ sections: Int, omittingEmptySlices: Bool = true) -> [ArraySlice<Element>] {
        guard count >= sections else {
            if omittingEmptySlices {
                return (0..<count).map { self[$0..<$0+1] }
            } else {
                return (0..<count).map { self[$0..<$0+1] } + (count..<sections).map { _ in ArraySlice() }
            }
        }
        
        let minSectionSize = self.count / sections
        let plusOnes = self.count % sections
        
        var result = [ArraySlice<Element>]()
        result.reserveCapacity(sections)
        
        var l = 0
        var r = minSectionSize + 1
        for _ in 0..<plusOnes {
            let slice = self[l..<r]
            result.append(slice)
            l += minSectionSize + 1
            r += minSectionSize + 1
        }
        r -= 1
        for _ in plusOnes..<sections {
            let slice = self[l..<r]
            result.append(slice)
            l += minSectionSize
            r += minSectionSize
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
