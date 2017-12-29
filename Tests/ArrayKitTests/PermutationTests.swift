import XCTest
import ArrayKit

class PermutationTests: XCTestCase {
    
    func testPermute() {
        do {
            let array = [0, 1, 2, 3, 4, 5]
            XCTAssertEqual(array.permuted(by: [2, 1, 0, 4, 5, 3]), [2, 1, 0, 4, 5, 3])
        }
    }
    
    func testRotate() {
        do {
            var array = [0, 1, 2, 3]
            array.rotate(n: 1)
            XCTAssertEqual(array, [1, 2, 3, 0])
            array.rotate(n: -2)
            XCTAssertEqual(array, [3, 0, 1, 2])
            array.rotate(n: 10)
            XCTAssertEqual(array, [1, 2, 3, 0])
            array.rotate(n: -10)
            XCTAssertEqual(array, [3, 0, 1, 2])
        }
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
