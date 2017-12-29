
import XCTest
import ArrayKit

class PerformanceTests: XCTestCase {
    
    func testSum() {
        let array = [Int](repeating: 0, count: 1000000)
        measure {
            _ = array.sum()!
        }
    }
    func testSumReduce() {
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
    func testSumReduceDouble() {
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
    func testSumReduceFloat80() {
        let array = [Float80](repeating: 0, count: 100000)
        measure {
            _ = array.reduce(0, +)
        }
    }
    
}
