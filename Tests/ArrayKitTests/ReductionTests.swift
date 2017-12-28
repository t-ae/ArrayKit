
import XCTest
import ArrayKit

class ReductionTests: XCTestCase {
    
    func testSum() {
        do {
            let array = [Int](0..<5)
            XCTAssertEqual(array.sum(), 10)
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
    }
    
}
