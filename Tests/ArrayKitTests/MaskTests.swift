import XCTest
import ArrayKit

class MaskTests: XCTestCase {
    
    func testNegate() {
        do {
            let array = [true, false, false, true]
            XCTAssertEqual(~array, [false, true, true, false])
        }
        do {
            let array = [Bool]()
            XCTAssertEqual(~array, [])
        }
    }
    
    func testAnd() {
        do {
            let lhs = [true, false, true, false]
            let rhs = [true, true, false, false]
            XCTAssertEqual(lhs & rhs, [true, false, false, false])
        }
        do {
            let lhs = [Bool]()
            let rhs = [Bool]()
            XCTAssertEqual(lhs & rhs, [])
        }
    }
    
    func testOr() {
        do {
            let lhs = [true, false, true, false]
            let rhs = [true, true, false, false]
            XCTAssertEqual(lhs | rhs, [true, true, true, false])
        }
        do {
            let lhs = [Bool]()
            let rhs = [Bool]()
            XCTAssertEqual(lhs | rhs, [])
        }
    }
    
    func testXor() {
        do {
            let lhs = [true, false, true, false]
            let rhs = [true, true, false, false]
            XCTAssertEqual(lhs ^ rhs, [false, true, true, false])
        }
        do {
            let lhs = [Bool]()
            let rhs = [Bool]()
            XCTAssertEqual(lhs ^ rhs, [])
        }
    }
    
    func testRandomMask() {
        let N = 100000
        let odds = 0.5
        let mask = [Bool].makeRandomMask(odds: odds, count: N)
        
        let mean = Double(mask.filter { $0 }.count) / Double(N)
        
        XCTAssertEqual(mean, odds, accuracy: 1e-1)
    }
    
    func testMask() {
        do {
            let array = [Int](0..<3)
            XCTAssertEqual(array.masked(with: [false, false, false]), [])
            XCTAssertEqual(array.masked(with: [false, false,  true]), [2])
            XCTAssertEqual(array.masked(with: [false, true,  false]), [1])
            XCTAssertEqual(array.masked(with: [false, true,   true]), [1, 2])
            XCTAssertEqual(array.masked(with: [true,  false, false]), [0])
            XCTAssertEqual(array.masked(with: [true,  false,  true]), [0, 2])
            XCTAssertEqual(array.masked(with: [true,  true,  false]), [0, 1])
            XCTAssertEqual(array.masked(with: [true,  true,   true]), [0, 1, 2])
        }
    }
}
