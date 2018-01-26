
import XCTest
import ArrayKit

class SearchingTests: XCTestCase {
    func testArgMin() {
        do {
            let array = [3, 2, 4, 1, 5, 7]
            XCTAssertEqual(array.argmin()!, 3)
        }
        do {
            let array = [Int]()
            XCTAssertNil(array.argmin())
        }
        do {
            let array = [0, 0, 0, 0, 0]
            XCTAssertEqual(array.argmin()!, 0)
        }
    }
    
    func testArgMax() {
        do {
            let array = [3, 2, 4, 1, 5, 0]
            XCTAssertEqual(array.argmax()!, 4)
        }
        do {
            let array = [Int]()
            XCTAssertNil(array.argmax())
        }
        do {
            let array = [0, 0, 0, 0, 0]
            XCTAssertEqual(array.argmax()!, 0)
        }
    }
}
