
import XCTest
import ArrayKit

class SequenceExtTests: XCTestCase {
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
}
