
import XCTest
import ArrayKit

class SeparationTests: XCTestCase {
    
    func testChunk() {
        do {
            let array = [Int](0..<10)
            let chunks = array.chunk(4)
            XCTAssertEqual(chunks.count, 4)
            XCTAssertEqual(chunks[0], ArraySlice(0..<3))
            XCTAssertEqual(chunks[1], ArraySlice(3..<6))
            XCTAssertEqual(chunks[2], ArraySlice(6..<8))
            XCTAssertEqual(chunks[3], ArraySlice(8..<10))
        }
        do {
            let array = [Int](0..<12)
            let chunks = array.chunk(4)
            XCTAssertEqual(chunks.count, 4)
            XCTAssertEqual(chunks[0], ArraySlice(0..<3))
            XCTAssertEqual(chunks[1], ArraySlice(3..<6))
            XCTAssertEqual(chunks[2], ArraySlice(6..<9))
            XCTAssertEqual(chunks[3], ArraySlice(9..<12))
        }
        do {
            let array = [Int](0..<3)
            let chunks = array.chunk(4)
            XCTAssertEqual(chunks.count, 3)
            XCTAssertEqual(chunks[0], ArraySlice(0..<1))
            XCTAssertEqual(chunks[1], ArraySlice(1..<2))
            XCTAssertEqual(chunks[2], ArraySlice(2..<3))
        }
    }
}
