
import Foundation

func rand_uniform() -> Double {
    return Double(arc4random()) / Double(UInt32.max)
}

extension Array {
    public func randomPick(by odds: [Double]) -> Element {
        precondition(odds.count == count, "`odds` size must match with array size.")
        
        let r = rand_uniform()
        
        var acc: Double = 0
        for i in 0..<odds.count {
            acc += odds[i]
            if acc >= r {
                return self[i]
            }
        }
        fatalError("No elements picked.")
    }
    
    public func randomPick(cumulativeOdds: [Double]) -> Element {
        precondition(cumulativeOdds.count == count, "`cumulativeOdds` size must match with array size.")
        let r = rand_uniform()
        let index = cumulativeOdds.index { $0 > r }!
        return self[index]
    }
}

extension Array {
    public mutating func shuffle() {
        precondition(count <= UInt32.max, "Humongous arrays are not supported.")
        
        for i in (0..<count).reversed() {
            let r = Int(arc4random_uniform(UInt32(i)))
            let temp = self[i]
            self[i] = self[r]
            self[r] = temp
        }
    }
    
    public func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }
}
