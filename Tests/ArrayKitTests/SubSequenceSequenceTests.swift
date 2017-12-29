
import XCTest
import ArrayKit

class SubSequenceSequenceTests: XCTestCase {
    
    func testSubSequences() {
        do {
            let array = [3, 4, 5]
            var subs = array.subSequences().makeIterator()
            
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
            var subs = array.subSequences(of: 2).makeIterator()
            
            XCTAssertEqual(subs.next(), [3, 4])
            XCTAssertEqual(subs.next(), [4, 5])
            XCTAssertNil(subs.next())
        }
        
        do {
            let array = [3, 4, 5]
            var subs = array.subSequences(of: 10).makeIterator()
            
            XCTAssertNil(subs.next())
        }
        
        do {
            let array = [Int]()
            var subs = array.subSequences().makeIterator()
            
            XCTAssertEqual(subs.next(), [])
            XCTAssertNil(subs.next())
        }
    }
}
