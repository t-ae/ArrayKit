
import XCTest
import ArrayKit

class SubSequenceIteratorTests: XCTestCase {
    
    func testSubSequences() {
        do {
            let array = [3, 4, 5]
            var subs = array.subSequences()
            
            XCTAssertEqual(subs.next(), [])
            XCTAssertEqual(subs.next(), [3])
            XCTAssertEqual(subs.next(), [4])
            XCTAssertEqual(subs.next(), [5])
            XCTAssertEqual(subs.next(), [3, 4])
            XCTAssertEqual(subs.next(), [4, 5])
            XCTAssertEqual(subs.next(), [3, 4, 5])
            XCTAssertNil(subs.next())
        }
        
        do {
            let array = [3, 4, 5]
            var subs = array.subSequences(of: 2)
            
            XCTAssertEqual(subs.next(), [3, 4])
            XCTAssertEqual(subs.next(), [4, 5])
            XCTAssertNil(subs.next())
        }
        
        do {
            let array = [3, 4, 5]
            var subs = array.subSequences(of: 10)
            
            XCTAssertNil(subs.next())
        }
        
        do {
            let array = [Int]()
            var subs = array.subSequences()
            
            XCTAssertEqual(subs.next(), [])
            XCTAssertNil(subs.next())
        }
        
        do {
            let array = [3, 4, 5]
            var i1 = array.subSequences(of: 2)
            
            XCTAssertEqual(i1.next(), [3, 4])
            
            var i2 = i1.makeIterator()
            XCTAssertEqual(i1.next(), [4, 5])
            XCTAssertNil(i1.next())
            XCTAssertEqual(i2.next(), [4, 5])
            XCTAssertNil(i2.next())
        }
    }
}
