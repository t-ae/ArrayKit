
import XCTest
import ArrayKit

class BoolTests: XCTestCase {
    
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
    
}
