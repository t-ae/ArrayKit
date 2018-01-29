
import XCTest
import ArrayKit

class SearchingTests: XCTestCase {
    func testArgMin() {
        do {
            let array = [3, 2, 4, 1, 5, 7]
            XCTAssertEqual(array.argmin()!, 3)
            XCTAssertEqual(array[0..<3].argmin()!, 1)
        }
        do {
            let array = [Int]()
            XCTAssertNil(array.argmin())
        }
        do {
            let array = [0, 0, 0, 0, 0]
            XCTAssertEqual(array.argmin()!, 0)
        }
        do {
            let string = "humpty dumpty sat on a wall"
            XCTAssertEqual(string.argmin(), string.index(of: " "))
        }
    }
    
    func testArgMax() {
        do {
            let array = [3, 2, 4, 1, 5, 0]
            XCTAssertEqual(array.argmax()!, 4)
            XCTAssertEqual(array[0..<4].argmax()!, 2)
        }
        do {
            let array = [Int]()
            XCTAssertNil(array.argmax())
        }
        do {
            let array = [0, 0, 0, 0, 0]
            XCTAssertEqual(array.argmax()!, 0)
        }
        do {
            let string = "humpty dumpty sat on a wall"
            XCTAssertEqual(string.argmax(), string.index(of: "y"))
        }
    }
}
