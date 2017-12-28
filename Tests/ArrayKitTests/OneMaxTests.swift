
import XCTest
import ArrayKit

func rand() -> Double {
    return Double(arc4random()) / Double(UInt32.max)
}

func calcScore(_ i: [Bool]) -> Double {
    return Double(i.filter { $0 }.count) / Double(i.count)
}

func crossover(_ lhs: [Bool], _ rhs: [Bool]) -> [Bool] {
    assert(lhs.count == rhs.count)
    
    let right = arc4random_uniform(UInt32(lhs.count))
    let left = arc4random_uniform(right)
    
    var result = lhs
    for i in Int(left)...Int(right) {
        result[i] = rhs[i]
    }
    return result
}

func describe(_ i: [Bool]) -> String {
    return String(i.map { $0 ? "1" : "0" })
}

class OneMaxTests: XCTestCase {
    
    let N = 128
    let length = 128
    
    func testOneMax() {
        
        // init
        var group = [[Bool]]()
        for _ in 0..<N {
            group.append([Bool].makeRandomMask(odds: 0.5, count: length))
        }
        
        for i in 1..<3000 {
            print("Generation: \(i)")
            
            var scores = group.map(calcScore)
            let sumScores = scores.reduce(0, +)
            let meanScores = sumScores / Double(N)
            let maxScore = scores.max()!
            print("mean: \(meanScores) max: \(maxScore)")
            
            if meanScores > 0.99 || maxScore == 1 {
                break
            }
            
            let order = scores.argsort()
            group.permute(by: order)
            scores.permute(by: order)
            let odds = scores.map { $0 / sumScores }
            let cumulativeOdds = odds.scan(0, +)
            
            
            var nextGroup = [[Bool]]()
            
            // elite
            nextGroup.append(group.last!)
            
            // crossover
            for _ in 1..<N {
                let g1 = group.randomPick(cumulativeOdds: cumulativeOdds)
                let g2 = group.randomPick(cumulativeOdds: cumulativeOdds)
                
                let new = crossover(g1, g2)
                nextGroup.append(new)
            }
            
            // mutation
            for i in 1..<N {
                if rand() < 0.01 {
                    /// flip if true
                    let mask = [Bool].makeRandomMask(odds: 0.01, count: length)
                    nextGroup[i] = nextGroup[i] ^ mask
                }
            }
            
            group = nextGroup
        }
        
        let scores = group.map(calcScore)
        let index = scores.index(of: scores.max()!)!
        let answer = group[index]
        print("answer: \(describe(answer))")
        
    }
    
}
