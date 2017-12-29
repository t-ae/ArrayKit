
import XCTest
import ArrayKit

class PerformanceTests: XCTestCase {
}

// MARK: - Sum
extension PerformanceTests {
    func testSum() {
        let array = [Int](repeating: 0, count: 1000000)
        measure {
            _ = array.sum()!
        }
    }
    func testSumEquivalent() {
        let array = [Int](repeating: 0, count: 1000000)
        measure {
            _ = array.reduce(0, +)
        }
    }
    
    
    func testSumDouble() {
        let array = [Double](repeating: 0, count: 1000000)
        measure {
            _ = array.sum()!
        }
    }
    func testSumDoubleEquivalent() {
        let array = [Double](repeating: 0, count: 1000000)
        measure {
            _ = array.reduce(0, +)
        }
    }
    
    
    func testSumFloat80() {
        let array = [Float80](repeating: 0, count: 100000)
        measure {
            _ = array.sum()!
        }
    }
    func testSumFloat80Equivalent() {
        let array = [Float80](repeating: 0, count: 100000)
        measure {
            _ = array.reduce(0, +)
        }
    }
}

// MARK: - QuickSelect
extension PerformanceTests {
    func testQuickSelect() {
        let array = [Int](0..<100000).shuffled()
        measure {
            _ = array.quickSelect(k: 1000)
        }
    }
    func testQuickSelectEquivalent() {
        let array = [Int](0..<100000).shuffled()
        measure {
            let sorted = array.sorted()
            _ = sorted[1000]
        }
    }
}

// MARK: - Mode
extension PerformanceTests {
    func testModes() {
        let array = [Int](0..<100000).shuffled() + [0]
        measure {
            _ = array.modes()
        }
    }
    
    func testModesEquivalent() {
        let array = [Int](0..<100000).shuffled() + [0]
        measure {
            var dict = [Int: Int]()
            for e in array {
                if dict[e] == nil {
                    dict[e] = 1
                } else {
                    dict[e]! += 1
                }
            }
            let entries = dict.sorted { a, b in a.value > b.value }
            let maxnum = entries.first!.value
            var modes = [Int]()
            for (k, v) in entries {
                if v != maxnum {
                    break
                }
                modes.append(k)
            }
            _ = modes
        }
    }
}
