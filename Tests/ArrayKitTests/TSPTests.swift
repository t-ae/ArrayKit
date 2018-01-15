
// traveling salesman problem

import XCTest
import ArrayKit

// Utils
private struct Point {
    let x: Double
    let y: Double
}
private func distance(_ a: Point, _ b: Point) -> Double {
    return sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y))
}

private func rand() -> Double {
    return Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
}

private typealias Individual = [Int]

private func totalDistance(root: Individual) -> Double {
    var ret = distanceTable[root.first!][root.last!]
    for (a, b) in zip(root, root.dropFirst()) {
        ret += distanceTable[a][b]
    }
    return ret
}

// problem: cities on unit circle
private let numCities = 32
private let cities = (0..<numCities)
    .map { Double($0) * 2 * Double.pi / Double(numCities) }
    .map { Point(x: cos($0),y: sin($0)) }

private let distanceTable = (0..<numCities).map { a in (0..<numCities).map { b in distance(cities[a], cities[b]) } }

// true minimum distance
private let minimumTotalDistance = Double(numCities) * sqrt(1 + 1 - 2*cos(2 * Double.pi / Double(numCities)))

private func crossover(_ a: Individual, _ b: Individual) -> (Individual, Individual) {
    let index = Int(arc4random_uniform(UInt32(a.count-1))) + 1
    
    let l = Individual(a[0..<index] + b.filter { !a[0..<index].contains($0) })
    let r = Individual(b[0..<index] + a.filter { !b[0..<index].contains($0) })
    
    return (l, r)
}

class TSPTests: XCTestCase {
    
    let N = 256
    
    func testTSP() {
        // init
        var group = [Individual]()
        for _ in 0..<N {
            group.append([Int](0..<numCities).shuffled())
        }
        
        for i in 1..<3000 {
            print("Generation: \(i)")
            
            let distances = group.map(totalDistance)
            var scores = distances.map { 1 / $0 }
            let sumScores = scores.sum()!
            let meanDistance = distances.sum()! / Double(group.count)
            let minDistance = distances.min()!
            print("mean: \(meanDistance) min: \(minDistance)")
            
            if distances.min()! <= minimumTotalDistance + 1e-3 {
                break
            }
            
            let order = scores.argsort(by: >)
            group.permute(by: order)
            scores.permute(by: order)
            let odds = scores.map { $0 / sumScores }
            
            var nextGroup = [Individual]()
            
            // elite
            nextGroup.append(contentsOf: group[0..<8])
            
            // crossover
            while nextGroup.count < N {
                let p = group.randomPick(n: 2, by: odds)!
                
                let (r1, r2) = crossover(p[0], p[1])
                nextGroup.append(r1)
                nextGroup.append(r2)
            }
            
            // mutation
            for i in 1..<nextGroup.count {
                if rand() < 0.01 {
                    let a = Int(arc4random_uniform(UInt32(nextGroup[i].count)))
                    let b = Int(arc4random_uniform(UInt32(nextGroup[i].count)))
                    let tmp = nextGroup[i][a]
                    nextGroup[i][a] = nextGroup[i][b]
                    nextGroup[i][b] = tmp
                }
            }
            
            group = nextGroup
        }
        
        let distances = group.map(totalDistance)
        let index = distances.index(of: distances.min()!)!
        let answer = group[index]
        print("answer: \(answer)")
        print("distance: \(distances[index]), true: \(minimumTotalDistance)")
    }
}
