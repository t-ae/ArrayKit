import XCTest
import ArrayKit

class ArrayKitTests: XCTestCase {
    
    func testArgSort() {
        do {
            let array = [3, 4, 2, 1, 5, 0]
            XCTAssertEqual(array.argsort(), [5, 3, 2, 0, 1, 4])
            XCTAssertEqual(array.argsort(by: >), [4, 1, 0, 2, 3, 5])
        }
        do {
            let array = [3]
            XCTAssertEqual(array.argsort(), [0])
            XCTAssertEqual(array.argsort(by: >), [0])
        }
    }
    
    func testPermute() {
        do {
            let array = [0, 1, 2, 3, 4, 5]
            XCTAssertEqual(array.permuted(by: [2, 1, 0, 4, 5, 3]), [2, 1, 0, 4, 5, 3])
        }
    }
    
    func testScan() {
        do {
            let array = [3, 4, 2, 1, 5, 0]
            XCTAssertEqual(array.scan(0, +), [3, 7, 9, 10, 15, 15])
            XCTAssertEqual(array.scan(1, *), [3, 12, 24, 24, 120, 0])
        }
        do {
            let array = [Int]()
            XCTAssertEqual(array.scan(0, +), [])
            XCTAssertEqual(array.scan(1, *), [])
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
