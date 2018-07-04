import XCTest
import ArrayKit

class PermutationIteratorTests: XCTestCase {
    
    func testPermutation() {
        do {
            let array = [3, 4, 5]
            var perms = array.permutations()
            
            XCTAssertEqual(perms.next(), [3, 4, 5])
            XCTAssertEqual(perms.next(), [3, 5, 4])
            XCTAssertEqual(perms.next(), [4, 3, 5])
            XCTAssertEqual(perms.next(), [4, 5, 3])
            XCTAssertEqual(perms.next(), [5, 3, 4])
            XCTAssertEqual(perms.next(), [5, 4, 3])
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [3, 4, 5]
            var perms = array.permutations(k: 2)
            
            XCTAssertEqual(perms.next(), [3, 4])
            XCTAssertEqual(perms.next(), [3, 5])
            XCTAssertEqual(perms.next(), [4, 3])
            XCTAssertEqual(perms.next(), [4, 5])
            XCTAssertEqual(perms.next(), [5, 3])
            XCTAssertEqual(perms.next(), [5, 4])
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [3, 4, 5]
            var perms = array.permutations(k: 4)
            
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [3, 4, 5]
            var perms = array.permutations(k: 0)
            
            XCTAssertEqual(perms.next(), [])
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [Int]()
            var perms = array.permutations()
            
            XCTAssertEqual(perms.next(), [])
            XCTAssertNil(perms.next())
        }
        
        do {
            let array = [3, 4]
            var i1 = array.permutations(k: 2)
            
            XCTAssertEqual(i1.next(), [3, 4])
            
            var i2 = i1.makeIterator()
            XCTAssertEqual(i1.next(), [4, 3])
            XCTAssertNil(i1.next())
            XCTAssertEqual(i2.next(), [4, 3])
            XCTAssertNil(i2.next())
        }
    }
}
