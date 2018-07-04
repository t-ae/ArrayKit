import XCTest
import ArrayKit

class SortTests: XCTestCase {
    
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
        do {
            let array = [3, 4, 2, 1, 5, 0]
            XCTAssertEqual(array[1..<4].argsort(), [3, 2, 1])
        }
    }
    
    func testStableSort() {
        do {
            let array = Array([Int](0..<3).permutations(k: 2).reversed())
            XCTAssertEqual(array, [[2, 1], [2, 0], [1, 2], [1, 0], [0, 2], [0, 1]])
            
            let result = array.stableSorted { $0[0] < $1[0] }
            
            XCTAssertEqual(result, [[0, 2], [0, 1], [1, 2], [1, 0], [2, 1], [2, 0]])
        }
        do {
            let array = Array([Int](0..<3).permutations(k: 2).reversed())
            XCTAssertEqual(array, [[2, 1], [2, 0], [1, 2], [1, 0], [0, 2], [0, 1]])
            
            let result = array[1..<4].stableSorted { $0[0] < $1[0] }
            
            XCTAssertEqual(result, [[1, 2], [1, 0], [2, 0]])
        }
    }
}
