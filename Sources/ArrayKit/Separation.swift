
extension Array {
    /// Separates array into `chunks` slices.
    /// If `count < chunks`, return array contains `count` single element slices.
    public func chunk(_ chunks: Int) -> [ArraySlice<Element>] {
        
        guard count >= chunks else {
            return (0..<count).map { self[$0..<$0+1] }
        }
        
        let minChunkLength = self.count / chunks
        let plusOnes = self.count % chunks
        
        var result = [ArraySlice<Element>]()
        result.reserveCapacity(chunks)
        
        var l = 0
        var r = minChunkLength + 1
        for _ in 0..<plusOnes {
            let slice = self[l..<r]
            result.append(slice)
            l += minChunkLength + 1
            r += minChunkLength + 1
        }
        r -= 1
        for _ in plusOnes..<chunks {
            let slice = self[l..<r]
            result.append(slice)
            l += minChunkLength
            r += minChunkLength
        }
        return result
    }
}
