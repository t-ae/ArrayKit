
import XCTest
import ArrayKit

class CombinationTests: XCTestCase {
    
    func testCombination() {
        
        do {
            let array = [3, 4, 5]
            var combs = array.combinations(k: 1).makeIterator()
            
            XCTAssertEqual(combs.next()!, [3])
            XCTAssertEqual(combs.next()!, [4])
            XCTAssertEqual(combs.next()!, [5])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [3, 4, 5]
            var combs = array.combinations(k: 2).makeIterator()
            
            XCTAssertEqual(combs.next()!, [3, 4])
            XCTAssertEqual(combs.next()!, [3, 5])
            XCTAssertEqual(combs.next()!, [4, 5])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [3, 4]
            var combs = array.combinations(k: 2).makeIterator()
            
            XCTAssertEqual(combs.next()!, [3, 4])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [3, 4, 5, 6, 7]
            var combs = array.combinations(k: 4).makeIterator()
            
            XCTAssertEqual(combs.next()!, [3, 4, 5, 6])
            XCTAssertEqual(combs.next()!, [3, 4, 5, 7])
            XCTAssertEqual(combs.next()!, [3, 4, 6, 7])
            XCTAssertEqual(combs.next()!, [3, 5, 6, 7])
            XCTAssertEqual(combs.next()!, [4, 5, 6, 7])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [Int]()
            var combs = array.combinations(k: 2).makeIterator()
            
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [1, 2, 3]
            var combs = array.combinations(k: 0).makeIterator()
            
            XCTAssertEqual(combs.next()!, [])
            XCTAssertNil(combs.next())
        }
        
        do {
            let array = [Int]()
            var combs = array.combinations(k: 0).makeIterator()
            
            XCTAssertEqual(combs.next()!, [])
            XCTAssertNil(combs.next())
        }
    }
}
