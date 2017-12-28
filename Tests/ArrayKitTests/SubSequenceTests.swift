
import XCTest
import ArrayKit

class SubSequenceTests: XCTestCase {
    
    func testSubSequences() {
        do {
            let array = [3, 4, 5]
            var subs = array.subSequences().makeIterator()
            
            XCTAssertEqual(subs.next()!, ArraySlice([]))
            XCTAssertEqual(subs.next()!, ArraySlice([3]))
            XCTAssertEqual(subs.next()!, ArraySlice([4]))
            XCTAssertEqual(subs.next()!, ArraySlice([5]))
            XCTAssertEqual(subs.next()!, ArraySlice([3, 4]))
            XCTAssertEqual(subs.next()!, ArraySlice([4, 5]))
            XCTAssertEqual(subs.next()!, ArraySlice([3, 4, 5]))
            XCTAssertNil(subs.next())
        }
        
        do {
            let array = [3, 4, 5]
            var subs = array.subSequences(of: 2).makeIterator()
            
            XCTAssertEqual(subs.next()!, ArraySlice([3, 4]))
            XCTAssertEqual(subs.next()!, ArraySlice([4, 5]))
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
            
            XCTAssertEqual(subs.next()!, ArraySlice([]))
            XCTAssertNil(subs.next())
        }
    }
}
