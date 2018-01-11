
extension Array where Element: Numeric {
    /// Returns sum of elements.
    public func sum() -> Element? {
        guard let f = self.first else {
            return nil
        }
        return self.dropFirst().reduce(f, +)
    }
}

extension Array where Element: Comparable {
    /// Returns median of elements.
    ///
    /// This method doesn't consider exceptional values(like FloatingPoint.nan).
    /// Remove them before use this method.
    public func median() -> Element? {
        guard count > 0 else {
            return nil
        }
        return quickSelect(k: count/2)
    }
}

extension Array where Element: Hashable {
    /// Returns set of modes.
    public func modes() -> Set<Element> {
        guard count > 0 else {
            return []
        }
        
        var bag = [Element: Int]()
        for e in self {
            if bag[e] == nil {
                bag[e] = 1
            } else {
                bag[e]! += 1
            }
        }
        
        var modes: Set<Element> = []
        var currentMax = Int.min
        for (k, v) in bag {
            if v > currentMax {
                modes = [k]
                currentMax = v
            } else if v == currentMax {
                modes.insert(k)
            }
        }
        
        return modes
    }
}

extension Array where Element == Int {
    /// Returns mean of elements.
    public func mean() -> Double? {
        return self.sum().map { Double($0) / Double(self.count) }
    }
    
    /// Returns variance of elements.
    public func variance() -> Double? {
        return self.moments()?.variance
    }
    
    /// Returns mean and variance of elements.
    public func moments() -> (mean: Double, variance: Double)? {
        guard count > 0 else {
            return nil
        }
        var sum: Element = 0
        var sum2: Element = 0
        for e in self {
            sum += e
            sum2 += e*e
        }
        let mean = Double(sum) / Double(count)
        let variance = Double(sum2) / Double(count) - mean*mean
        
        return (mean, variance)
    }
}

extension Array where Element: FloatingPoint {
    /// Returns sum of elements.
    public func sum() -> Element? {
        guard count > 0 else {
            return nil
        }
        
        // To mitigate computation error.
        var src = self
        while src.count > 1 {
            let c = (src.count+1)/2
            var dst = [Element](repeating: 0, count: c)
            for i in 0..<c-1 {
                dst[i] = src[2*i] + src[2*i+1]
            }
            if src.count % 2 == 0 {
                dst[c-1] = src[2*(c-1)] + src[2*(c-1)+1]
            } else {
                dst[c-1] = src[2*(c-1)]
            }
            
            src = dst
        }
        
        return src.first!
    }
    
    /// Returns mean of elements.
    public func mean() -> Element? {
        return self.sum().map { $0 / Element(self.count) }
    }
    
    /// Returns variance of elements.
    public func variance() -> Element? {
        return self.moments()?.variance
    }
    
    /// Returns mean and variance of elements.
    public func moments() -> (mean: Element, variance: Element)? {
        var sum: Element = 0
        var sum2: Element = 0
        for e in self {
            sum += e
            sum2 += e*e
        }
        let mean = sum / Element(count)
        let variance = sum2 / Element(count) - mean*mean
        
        return (mean, variance)
    }
}

#if os(macOS) || os(iOS)
    import Accelerate
    
    extension Array where Element == Float {
        /// Returns sum of elements.
        public func sum() -> Element? {
            guard count > 0 else {
                return nil
            }
            var result: Element = 0
            vDSP_sve(self, 1, &result, vDSP_Length(count))
            return result
        }
        
        /// Returns mean of elements.
        public func mean() -> Element? {
            guard count > 0 else {
                return nil
            }
            var result: Element = 0
            vDSP_meanv(self, 1, &result, vDSP_Length(count))
            return result
        }
        
        /// Returns variance of elements.
        public func variance() -> Element? {
            return self.moments()?.variance
        }
        
        /// Returns mean and variance of elements.
        public func moments() -> (mean: Element, variance: Element)? {
            guard count > 0 else {
                return nil
            }
            var sum: Element = 0
            var sum2: Element = 0
            vDSP_sve_svesq(self, 1, &sum, &sum2, vDSP_Length(count))
            let mean = sum / Element(count)
            let variance = sum2 / Element(count) - mean*mean
            
            return (mean, variance)
        }
    }
    
    extension Array where Element == Double {
        /// Returns sum of elements.
        public func sum() -> Element? {
            guard count > 0 else {
                return nil
            }
            var result: Element = 0
            vDSP_sveD(self, 1, &result, vDSP_Length(count))
            return result
        }
        
        /// Returns mean of elements.
        public func mean() -> Element? {
            guard count > 0 else {
                return nil
            }
            var result: Element = 0
            vDSP_meanvD(self, 1, &result, vDSP_Length(count))
            return result
        }
        
        /// Returns variance of elements.
        public func variance() -> Element? {
            return self.moments()?.variance
        }
        
        /// Returns mean and variance of elements.
        public func moments() -> (mean: Element, variance: Element)? {
            guard count > 0 else {
                return nil
            }
            var sum: Element = 0
            var sum2: Element = 0
            vDSP_sve_svesqD(self, 1, &sum, &sum2, vDSP_Length(count))
            let mean = sum / Element(count)
            let variance = sum2 / Element(count) - mean*mean
            
            return (mean, variance)
        }
    }
#endif
