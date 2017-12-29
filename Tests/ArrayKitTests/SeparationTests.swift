
import XCTest
import ArrayKit

class SeparationTests: XCTestCase {
    
    func testChunk() {
        do {
            let array = [Int](0..<10)
            let chunks = array.chunk(4)
            
            XCTAssertEqual(chunks, [ArraySlice(0..<3),
                                    ArraySlice(3..<6),
                                    ArraySlice(6..<8),
                                    ArraySlice(8..<10)])
        }
        do {
            let array = [Int](0..<12)
            let chunks = array.chunk(4)
            
            XCTAssertEqual(chunks, [ArraySlice(0..<3),
                                    ArraySlice(3..<6),
                                    ArraySlice(6..<9),
                                    ArraySlice(9..<12)])
        }
        do {
            let array = [Int](0..<3)
            let chunks = array.chunk(4)
            
            XCTAssertEqual(chunks, [ArraySlice(0..<1),
                                    ArraySlice(1..<2),
                                    ArraySlice(2..<3)])
        }
    }
}
