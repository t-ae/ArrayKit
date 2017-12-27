//
//  OneMaxTests.swift
//  ArrayKitTests
//
//  Created by Araki Takehiro on 2017/12/27.
//

import XCTest

func rand() -> Double {
    return Double(arc4random()) / Double(UInt32.max)
}

func calcScore(_ i: UInt32) -> Double {
    let str = String(i, radix: 2)
    let ones = str.filter { $0 == "1" }
    let ct = ones.count
    return Double(ct) / 32
}

func crossover(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    let mask: UInt32
    do {
        let a = arc4random_uniform(31) + 1 // 1 ~ 32
        let b = arc4random_uniform(a - 1) // 0 ~ a-1
        mask = (UInt32.max >> a) << b
    }
    
    return (lhs & mask) | (rhs & ~mask)
    
}

class OneMaxTests: XCTestCase {
    
    let N = 128
    
    func testOneMax() {
        
        // init
        var group = [UInt32]()
        for _ in 0..<N {
            group.append(arc4random())
        }
        
        for i in 1..<10000 {
            print("Generation: \(i)")
            
            var scores = group.map(calcScore)
            let sumScores = scores.reduce(0, +)
            let meanScores = sumScores / Double(N)
            let maxScore = scores.max()!
            print("mean: \(meanScores) max: \(maxScore)")
            
            let f = group.first!
            if group.filter({ $0 != f }).isEmpty {
                print("all same")
                break
            }
            
            if meanScores > 0.99 || maxScore == 1 {
                break
            }
            
            let order = scores.argsort()
            group.permute(by: order)
            scores.permute(by: order)
            let odds = scores.map { $0 / sumScores }
            let cumulativeOdds = odds.scan(0, +)
            
            
            var nextGroup = [UInt32]()
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
            for i in 0..<N {
                if rand() < 0.01 {
                    var a: UInt32 = 0
                    for _ in 0..<32 {
                        a <<= 1
                        if rand() < 0.05 {
                            a += 1
                        }
                    }
                    print("mutate: \(String(a, radix: 2))")
                    let new = a & (a ^ nextGroup[i]) | ~a & nextGroup[i]
                    nextGroup[i] = new
                }
            }
            
            group = nextGroup
        }
        
        let scores = group.map(calcScore)
        let index = scores.index(of: scores.max()!)!
        let answer = group[index]
        print("answer: \(String(answer, radix: 2))")
        
    }
    
}
