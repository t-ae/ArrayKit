
import XCTest
import ArrayKit

class RandomTests: XCTestCase {
    
    func testRandomPick_even() {
        do {
            let N = 100000
            let dice = [1, 2, 3, 4, 5, 6]
            let rolls = (0..<N).map { _ in dice.randomPick()! }
            let mean = rolls.mean()!
            XCTAssertEqual(mean, 3.5, accuracy: 1e-1)
        }
        do {
            let events: [Int] = []
            XCTAssertNil(events.randomPick())
        }
    }
    
    func testRandomPick_odds() {
        do {
            let N = 100000
            let coin = [0, 1]
            let flips = (0..<N).map { _ in coin.randomPick(by: [0.3, 0.7])! }
            let mean = flips.mean()!
            XCTAssertEqual(mean, 0.7, accuracy: 1e-1)
        }
        do {
            let events: [Int] = []
            XCTAssertNil(events.randomPick(by: []))
        }
    }
    
    func testRandomPick_cumulativeWeights() {
        do {
            let N = 100000
            let coin = [0, 1]
            let flips = (0..<N).map { _ in coin.randomPick(cumulativeWeights: [0.3, 1.0])! }
            let mean = flips.mean()!
            XCTAssertEqual(mean, 0.7, accuracy: 1e-1)
        }
        do {
            let events: [Int] = []
            XCTAssertNil(events.randomPick(cumulativeWeights: []))
        }
    }
    
    func testRandomPick_weights() {
        do {
            let N = 100000
            let dice = [1, 2, 3, 4, 5, 6]
            let rolls = (0..<N).map { _ in dice.randomPick(weights: [1, 1, 1, 1, 1, 1])! }
            let mean = rolls.mean()!
            XCTAssertEqual(mean, 3.5, accuracy: 1e-1)
        }
        do {
            let events: [Int] = []
            XCTAssertNil(events.randomPick(weights: []))
        }
    }
    
    func testRandomPick_n_even() {
        do {
            // even
            let N = 100000
            let events = [1, 2, 3]
            let pick2 = (0..<N).map { _ in events.randomPick(n: 2)! }
            
            // all elements are distinct
            XCTAssertFalse(pick2.contains { $0[0] == $0[1] })
            
            var bag = [Int: Int]()
            bag.reserveCapacity(6)
            for e in pick2 {
                let k = e[0]*5 + e[1]
                if bag[k] == nil {
                    bag[k] = 1
                } else {
                    bag[k]! += 1
                }
            }
            
            // all pairs are picked almost same probabilities
            let probs = bag.map { Double($0.value) / Double(N) }
            for p in probs {
                XCTAssertEqual(p, 1/Double(6), accuracy: 1e-2)
            }
        }
        do {
            let events = [1, 2, 3]
            let pick = events.randomPick(n: 3)!
            XCTAssertEqual(Set(pick), Set(events))
        }
    }
    
    func testRandomPick_n_odds() {
        do {
            let N = 100000
            let events = [1, 2, 3]
            let pick2 = (0..<N).map { _ in events.randomPick(n: 2, by: [0.333, 0.333, 0.333])! }
            
            // all elements are distinct
            XCTAssertFalse(pick2.contains { $0[0] == $0[1] })
            
            var bag = [Int: Int]()
            bag.reserveCapacity(3)
            for e in pick2 {
                let k = e[0]*5 + e[1]
                if bag[k] == nil {
                    bag[k] = 1
                } else {
                    bag[k]! += 1
                }
            }
            
            // all pairs are picked almost same probabilities
            let probs = bag.map { Double($0.value) / Double(N) }
            for p in probs {
                XCTAssertEqual(p, 1/Double(6), accuracy: 1e-2)
            }
        }
        do {
            let events = [1, 2, 3]
            let pick = events.randomPick(n: 3, by: [0.1, 0.2, 0.3])!
            XCTAssertEqual(Set(pick), Set(events))
        }
    }
    
    func testRandomPick_n_weights() {
        do {
            let N = 100000
            let events = [1, 2, 3]
            let pick2 = (0..<N).map { _ in events.randomPick(n: 2, weights: [1, 1, 1])! }
            
            // all elements are distinct
            XCTAssertFalse(pick2.contains { $0[0] == $0[1] })
            
            var bag = [Int: Int]()
            bag.reserveCapacity(3)
            for e in pick2 {
                let k = e[0]*5 + e[1]
                if bag[k] == nil {
                    bag[k] = 1
                } else {
                    bag[k]! += 1
                }
            }
            
            // all pairs are picked almost same probabilities
            let probs = bag.map { Double($0.value) / Double(N) }
            for p in probs {
                XCTAssertEqual(p, 1/Double(6), accuracy: 1e-2)
            }
        }
        do {
            let events = [1, 2, 3]
            let pick = events.randomPick(n: 3, weights: [1, 1, 1])!
            XCTAssertEqual(Set(pick), Set(events))
        }
    }
    
    func testRandomSlice() {
        do {
            // excludes empty
            let array = [3, 4, 5, 6]
            
            let N = 100000
            var bag = [Int: Int]()
            
            for _ in 0..<N {
                let slice = array.randomSlice()
                let key = slice.startIndex * 13 + slice.endIndex
                if bag[key] == nil {
                    bag[key] = 1
                } else {
                    bag[key]! += 1
                }
            }
            // all pairs are picked almost same probabilities
            let probs = bag.map { Double($0.value) / Double(N) }
            for p in probs {
                XCTAssertEqual(p, 1/Double(10), accuracy: 1e-2)
            }
        }
        do {
            // includes empty
            let array = [3, 4, 5, 6]
            
            let N = 100000
            var bag = [Int: Int]()
            
            for _ in 0..<N {
                let slice = array.randomSlice(includesEmpty: true)
                let key = slice.startIndex * 13 + slice.endIndex
                if bag[key] == nil {
                    bag[key] = 1
                } else {
                    bag[key]! += 1
                }
            }
            // all pairs are picked almost same probabilities
            let probs = bag.map { Double($0.value) / Double(N) }
            for p in probs {
                XCTAssertEqual(p, 1/Double(11), accuracy: 1e-2)
            }
        }
    }
    
    func testShuffle() {
        do {
            let array = Array(0..<64)
            let shuffled = array.shuffled()
            
            XCTAssertEqual(Set(shuffled), Set(array))
            XCTAssertNotEqual(shuffled, array)
        }
        do {
            let array = [3]
            let shuffled = array.shuffled()
            
            XCTAssertEqual(shuffled, array)
        }
        do {
            let array = [Int]()
            let shuffled = array.shuffled()
            
            XCTAssertEqual(shuffled, array)
        }
    }
}
