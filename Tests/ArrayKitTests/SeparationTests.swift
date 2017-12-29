
import XCTest
import ArrayKit

class SeparationTests: XCTestCase {
    
    func testSplit() {
        do {
            let array = [Int](0..<10)
            let result = array.split(4)
            
            XCTAssertEqual(result, [ArraySlice(0..<3),
                                    ArraySlice(3..<6),
                                    ArraySlice(6..<8),
                                    ArraySlice(8..<10)])
        }
        do {
            let array = [Int](0..<12)
            let result = array.split(4)
            
            XCTAssertEqual(result, [ArraySlice(0..<3),
                                    ArraySlice(3..<6),
                                    ArraySlice(6..<9),
                                    ArraySlice(9..<12)])
        }
        do {
            let array = [Int](0..<3)
            let result = array.split(4)
            
            XCTAssertEqual(result, [ArraySlice(0..<1),
                                    ArraySlice(1..<2),
                                    ArraySlice(2..<3)])
        }
        do {
            let array = [Int](0..<3)
            let result = array.split(4, omittingEmptySlices: false)
            
            XCTAssertEqual(result, [ArraySlice(0..<1),
                                    ArraySlice(1..<2),
                                    ArraySlice(2..<3),
                                    ArraySlice()])
        }
    }
    
    func testChunk() {
        do {
            let array = [Int](0..<10)
            let result = array.chunk(3)
            
            XCTAssertEqual(result, [ArraySlice(0..<3),
                                    ArraySlice(3..<6),
                                    ArraySlice(6..<9),
                                    ArraySlice(9..<10)])
        }
        do {
            let array = [Int](0..<12)
            let result = array.chunk(3)
            
            XCTAssertEqual(result, [ArraySlice(0..<3),
                                    ArraySlice(3..<6),
                                    ArraySlice(6..<9),
                                    ArraySlice(9..<12)])
        }
        do {
            let array = [Int](0..<3)
            let result = array.chunk(5)
            
            XCTAssertEqual(result, [ArraySlice(0..<3)])
        }
    }
}
