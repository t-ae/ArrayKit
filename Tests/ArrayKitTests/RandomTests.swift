
import XCTest
import ArrayKit

class RandomTests: XCTestCase {
    
    func testRandomPick() {
        do {
            let N = 100000
            let dice = [1, 2, 3, 4, 5, 6]
            let rolls = (0..<N).map { _ in dice.randomPick() }
            let mean = Double(rolls.sum()!) / Double(N)
            XCTAssertEqual(mean, 3.5, accuracy: 1e-1)
        }
    }
    
}
