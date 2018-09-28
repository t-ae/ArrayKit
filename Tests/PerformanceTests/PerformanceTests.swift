import XCTest
import ArrayKit

#if !DEBUG

class PerformanceTests: XCTestCase {  }

// MARK: - Sum
extension PerformanceTests {
    func testSum() {
        let array = [Int](repeating: 0, count: 1000000)
        measure {
            let sum = array.sum()!
            XCTAssertEqual(sum, 0)
        }
    }
    func testSumEquivalent() {
        let array = [Int](repeating: 0, count: 1000000)
        measure {
            let sum = array.reduce(0, +)
            XCTAssertEqual(sum, 0)
        }
    }
    
    
    func testSumDouble() {
        let array = [Double](repeating: 0, count: 1000000)
        measure {
            let sum = array.sum()!
            XCTAssertEqual(sum, 0)
        }
    }
    func testSumDoubleEquivalent() {
        let array = [Double](repeating: 0, count: 1000000)
        measure {
            let sum = array.reduce(0, +)
            XCTAssertEqual(sum, 0)
        }
    }
    
    
    func testSumFloat80() {
        let array = [Float80](repeating: 0, count: 100000)
        measure {
            let sum = array.sum()!
            XCTAssertEqual(sum, 0)
        }
    }
    func testSumFloat80Equivalent() {
        let array = [Float80](repeating: 0, count: 100000)
        measure {
            let sum = array.reduce(0, +)
            XCTAssertEqual(sum, 0)
        }
    }
}

// MARK: - QuickSelect
extension PerformanceTests {
    func testQuickSelect() {
        let array = [Int](0..<100000).shuffled()
        measure {
            let median = array.quickSelect(k: 1000)
            XCTAssertEqual(median, 1000)
        }
    }
    func testQuickSelectEquivalent() {
        let array = [Int](0..<100000).shuffled()
        measure {
            let sorted = array.sorted()
            let median = sorted[1000]
            XCTAssertEqual(median, 1000)
        }
    }
}

// MARK: - Mode
extension PerformanceTests {
    func testModes() {
        let array = [Int](0..<100000).shuffled() + [0]
        measure {
            let modes = array.modes()
            XCTAssertEqual(modes, [0])
        }
    }
}

// MARKL - Rotate
extension PerformanceTests {
    func testRotate() {
        var array = [Int](0..<1000000)
        measure {
            array.rotate(n: 100)
        }
    }
    
    func testRotated() {
        var array = [Int](0..<1000000)
        measure {
            array = array.rotated(n: 100)
        }
    }
}

// MARK: Combinations
extension PerformanceTests {
    func testCombinations() {
        let array = [Int](0..<300)
        measure {
            var count = 0
            for c in array.combinations(k: 2) {
                _ = c
                count += 1
            }
            XCTAssertEqual(count, 300 * 299 / 2)
        }
    }
    
    func testCombinationsEquivalent() {
        let array = [Int](0..<300)
        measure {
            var count = 0
            for i in array.dropLast() {
                for j in array[(i+1)...] {
                    _ = [array[i], array[j]]
                    count += 1
                }
            }
            XCTAssertEqual(count, 300 * 299 / 2)
        }
    }
}

#endif
