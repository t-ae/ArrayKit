import XCTest
import ArrayKit

class PermutationTests: XCTestCase {
    
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
    
    func testRotate() {
        do {
            let array = [0, 1, 2, 3]
            XCTAssertEqual(array.rotated(n: -10), [2, 3, 0, 1])
            XCTAssertEqual(array.rotated(n: -1), [3, 0, 1, 2])
            XCTAssertEqual(array.rotated(n: 0), [0, 1, 2, 3])
            XCTAssertEqual(array.rotated(n: 1), [1, 2, 3, 0])
            XCTAssertEqual(array.rotated(n: 2), [2, 3, 0, 1])
            XCTAssertEqual(array.rotated(n: 3), [3, 0, 1, 2])
            XCTAssertEqual(array.rotated(n: 4), [0, 1, 2, 3])
            XCTAssertEqual(array.rotated(n: 5), [1, 2, 3, 0])
        }
    }
}
