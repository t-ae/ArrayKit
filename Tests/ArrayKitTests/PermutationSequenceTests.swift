
import XCTest
import ArrayKit

class PermutationSequenceTests: XCTestCase {
    
    func testPermutation() {
        do {
            let array = [3, 4, 5]
            var perms = array.permutations().makeIterator()
            
            XCTAssertEqual(perms.next()!, [3, 4, 5])
            XCTAssertEqual(perms.next()!, [3, 5, 4])
            XCTAssertEqual(perms.next()!, [4, 3, 5])
            XCTAssertEqual(perms.next()!, [4, 5, 3])
            XCTAssertEqual(perms.next()!, [5, 3, 4])
            XCTAssertEqual(perms.next()!, [5, 4, 3])
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [3, 4, 5]
            var perms = array.permutations(k: 2).makeIterator()
            
            XCTAssertEqual(perms.next()!, [3, 4])
            XCTAssertEqual(perms.next()!, [3, 5])
            XCTAssertEqual(perms.next()!, [4, 3])
            XCTAssertEqual(perms.next()!, [4, 5])
            XCTAssertEqual(perms.next()!, [5, 3])
            XCTAssertEqual(perms.next()!, [5, 4])
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [3, 4, 5]
            var perms = array.permutations(k: 4).makeIterator()
            
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [3, 4, 5]
            var perms = array.permutations(k: 0).makeIterator()
            
            XCTAssertEqual(perms.next()!, [])
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [Int]()
            var perms = array.permutations().makeIterator()
            
            XCTAssertEqual(perms.next()!, [])
            XCTAssertNil(perms.next())
        }
    }
}
