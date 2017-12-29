
extension Array {
    /// Separates array into `sections` slices.
    /// If `count < sections`, return array contains `count` single element slices.
    /// Note: It doesn't require `count % sections == 0`. Each slices' sizes may differ.
    public func split(_ sections: Int) -> [ArraySlice<Element>] {
        
        guard count >= sections else {
            return (0..<count).map { self[$0..<$0+1] }
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
    public func chunk(by size: Int) -> [ArraySlice<Element>] {
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
