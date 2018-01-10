
import XCTest
import ArrayKit

class StatisticsTests: XCTestCase {
    
    func testMedian() {
        do {
            let array = [Int](0..<100).shuffled()
            XCTAssertEqual(array.median(), 50)
        }
        do {
            let array = [Int]()
            XCTAssertNil(array.median())
        }
        do {
            let array = [1]
            XCTAssertEqual(array.median(), 1)
        }
    }
    
    func testModes() {
        do {
            let array = [1, 2, 3, 4, 5, 4, 3, 4].shuffled()
            XCTAssertEqual(array.modes(), [4])
        }
        do {
            let array = [1, 2, 3, 4, 5, 4, 3, 4, 3].shuffled()
            XCTAssertEqual(array.modes(), [3, 4])
        }
        do {
            let array: [Int] = []
            XCTAssertEqual(array.modes(), [])
        }
        do {
            let array = [1]
            XCTAssertEqual(array.modes(), [1])
        }
    }
    
    func testSum() {
        do {
            let array = [Int](0..<10000)
            XCTAssertEqual(array.sum(), array.reduce(0, +))
        }
        do {
            let array = (0..<5).map { Float($0) }
            XCTAssertEqual(array.sum(), 10)
        }
        do {
            let array = (0..<5).map { Double($0) }
            XCTAssertEqual(array.sum(), 10)
        }
        do {
            let array = (0..<5).map { Float80($0) }
            XCTAssertEqual(array.sum(), 10)
        }
        
        do {
            let array: [Int] = []
            XCTAssertNil(array.sum())
        }
        do {
            let array: [Float] = []
            XCTAssertNil(array.sum())
        }
        do {
            let array: [Double] = []
            XCTAssertNil(array.sum())
        }
        do {
            let array: [Float80] = []
            XCTAssertNil(array.sum())
        }
        
        do {
            let array: [Int] = [1]
            XCTAssertEqual(array.sum(), 1)
        }
        do {
            let array: [Float] = [1]
            XCTAssertEqual(array.sum(), 1)
        }
        do {
            let array: [Double] = [1]
            XCTAssertEqual(array.sum(), 1)
        }
        do {
            let array: [Float80] = [1]
            XCTAssertEqual(array.sum(), 1)
        }
    }
    
    func testMean() {
        do {
            let array = [Int](0..<5)
            XCTAssertEqual(array.mean(), 2)
        }
        do {
            let array = (0..<5).map { Float($0) }
            XCTAssertEqual(array.mean(), 2)
        }
        do {
            let array = (0..<5).map { Double($0) }
            XCTAssertEqual(array.mean(), 2)
        }
        
        do {
            let array: [Int] = []
            XCTAssertNil(array.mean())
        }
        do {
            let array: [Float] = []
            XCTAssertNil(array.mean())
        }
        do {
            let array: [Double] = []
            XCTAssertNil(array.mean())
        }
        
        do {
            let array: [Int] = [1]
            XCTAssertEqual(array.mean(), 1)
        }
        do {
            let array: [Float] = [1]
            XCTAssertEqual(array.mean(), 1)
        }
        do {
            let array: [Double] = [1]
            XCTAssertEqual(array.mean(), 1)
        }
        do {
            let array: [Float80] = [1]
            XCTAssertEqual(array.mean(), 1)
        }
    }
    
    func testVariance() {
        do {
            let array = [Int](0..<5)
            XCTAssertEqual(array.variance(), 2)
        }
        do {
            let array = (0..<5).map { Float($0) }
            XCTAssertEqual(array.variance(), 2)
        }
        do {
            let array = (0..<5).map { Double($0) }
            XCTAssertEqual(array.variance(), 2)
        }
        
        do {
            let array: [Int] = []
            XCTAssertNil(array.variance())
        }
        do {
            let array: [Float] = []
            XCTAssertNil(array.variance())
        }
        do {
            let array: [Double] = []
            XCTAssertNil(array.variance())
        }
        
        do {
            let array: [Int] = [1]
            XCTAssertEqual(array.variance(), 0)
        }
        do {
            let array: [Float] = [1]
            XCTAssertEqual(array.variance(), 0)
        }
        do {
            let array: [Double] = [1]
            XCTAssertEqual(array.variance(), 0)
        }
        do {
            let array: [Float80] = [1]
            XCTAssertEqual(array.variance(), 0)
        }
    }
    
    func testMoments() {
        do {
            let array = [Int](0..<5)
            let (mean, variance) = array.moments()!
            XCTAssertEqual(mean, 2)
            XCTAssertEqual(variance, 2)
        }
        do {
            let array = (0..<5).map { Float($0) }
            let (mean, variance) = array.moments()!
            XCTAssertEqual(mean, 2)
            XCTAssertEqual(variance, 2)
        }
        do {
            let array = (0..<5).map { Double($0) }
            let (mean, variance) = array.moments()!
            XCTAssertEqual(mean, 2)
            XCTAssertEqual(variance, 2)
        }
        
        do {
            let array: [Int] = []
            XCTAssertNil(array.moments())
        }
        do {
            let array: [Float] = []
            XCTAssertNil(array.moments())
        }
        do {
            let array: [Double] = []
            XCTAssertNil(array.moments())
        }
        
        do {
            let array: [Int] = [1]
            let (mean, variance) = array.moments()!
            XCTAssertEqual(mean, 1)
            XCTAssertEqual(variance, 0)
        }
        do {
            let array: [Float] = [1]
            let (mean, variance) = array.moments()!
            XCTAssertEqual(mean, 1)
            XCTAssertEqual(variance, 0)
        }
        do {
            let array: [Double] = [1]
            let (mean, variance) = array.moments()!
            XCTAssertEqual(mean, 1)
            XCTAssertEqual(variance, 0)
        }
    }
    
}
