
import XCTest
import ArrayKit

private func rand() -> Double {
    return Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
}

private typealias Individual = [Bool]

private func calcScore(_ i: Individual) -> Double {
    return Double(i.filter { $0 }.count) / Double(i.count)
}

// two point crossover
private func crossover(_ lhs: Individual, _ rhs: Individual) -> (Individual, Individual) {
    assert(lhs.count == rhs.count)
    
    var resultL = lhs
    var resultR = rhs
    for i in lhs.randomRange() {
        resultL[i] = rhs[i]
        resultR[i] = lhs[i]
    }
    return (resultL, resultR)
}

private func describe(_ i: [Bool]) -> String {
    return String(i.map { $0 ? "1" : "0" })
}

#if !SWIFT_PACKAGE
class OneMaxTests: XCTestCase {
    
    let N = 128
    let length = 128
    
    func testOneMax() {
        
        // init
        var group = [Individual]()
        for _ in 0..<N {
            group.append([Bool].makeRandomMask(odds: 0.5, count: length))
        }
        
        for i in 1..<3000 {
            print("Generation: \(i)")
            
            var scores = group.map(calcScore)
            let sumScores = scores.sum()!
            let meanScores = sumScores / Double(group.count)
            let maxScore = scores.max()!
            print("mean: \(meanScores) max: \(maxScore)")
            
            if meanScores > 0.99 || maxScore == 1 {
                break
            }
            
            let order = scores.argsort()
            group.permute(by: order)
            scores.permute(by: order)
            let odds = scores.map { $0 / sumScores }
            
            var nextGroup = [Individual]()
            
            // elite
            nextGroup.append(group.last!)
            
            // crossover
            while nextGroup.count < N {
                // roulette selection
                let p = group.randomElements(n: 2, weights: odds)!
                
                let (r1, r2) = crossover(p[0], p[1])
                nextGroup.append(r1)
                nextGroup.append(r2)
            }
            
            // mutation
            for i in 1..<nextGroup.count {
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
#endif
