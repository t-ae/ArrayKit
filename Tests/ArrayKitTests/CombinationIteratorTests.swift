
import XCTest
import ArrayKit

class CombinationIteratorTests: XCTestCase {
    
    func testCombination() {
        
        do {
            let array = [3, 4, 5]
            var combs = array.combinations(k: 1)
            
            XCTAssertEqual(combs.next(), [3])
            XCTAssertEqual(combs.next(), [4])
            XCTAssertEqual(combs.next(), [5])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [3, 4, 5]
            var combs = array.combinations(k: 2)
            
            XCTAssertEqual(combs.next(), [3, 4])
            XCTAssertEqual(combs.next(), [3, 5])
            XCTAssertEqual(combs.next(), [4, 5])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [3, 4]
            var combs = array.combinations(k: 2)
            
            XCTAssertEqual(combs.next(), [3, 4])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [3, 4, 5, 6, 7]
            var combs = array.combinations(k: 4)
            
            XCTAssertEqual(combs.next(), [3, 4, 5, 6])
            XCTAssertEqual(combs.next(), [3, 4, 5, 7])
            XCTAssertEqual(combs.next(), [3, 4, 6, 7])
            XCTAssertEqual(combs.next(), [3, 5, 6, 7])
            XCTAssertEqual(combs.next(), [4, 5, 6, 7])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [Int]()
            var combs = array.combinations(k: 2)
            
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [1, 2, 3]
            var combs = array.combinations(k: 0)
            
            XCTAssertEqual(combs.next(), [])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [Int]()
            var combs = array.combinations(k: 0)
            
            XCTAssertEqual(combs.next(), [])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [1, 2]
            var i1 = array.combinations(k: 1)
            
            XCTAssertEqual(i1.next(), [1])
            
            var i2 = i1.makeIterator()
            XCTAssertEqual(i1.next(), [2])
            XCTAssertNil(i1.next())
            XCTAssertEqual(i2.next(), [2])
            XCTAssertNil(i2.next())
        }
    }
}
