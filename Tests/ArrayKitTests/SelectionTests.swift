
import XCTest
import ArrayKit

private class Test: Comparable {
    let i: Int
    init(_ i: Int) {
        self.i = i
    }
    
    static func <(lhs: Test, rhs: Test) -> Bool {
        return lhs.i < rhs.i
    }
    
    static func ==(lhs: Test, rhs: Test) -> Bool {
        return lhs.i == rhs.i
    }
}

class SelectionTests: XCTestCase {
    
    func testQuickSelect() {
        do {
            let array = [Int](0..<1).shuffled()
            XCTAssertEqual(array.quickSelect(k: 0), 0)
        }
        do {
            let array = [Int](0..<10).shuffled()
            XCTAssertEqual(array.quickSelect(k: 0), 0)
            XCTAssertEqual(array.quickSelect(k: 1), 1)
            XCTAssertEqual(array.quickSelect(k: 2), 2)
            XCTAssertEqual(array.quickSelect(k: 3), 3)
            XCTAssertEqual(array.quickSelect(k: 4), 4)
            XCTAssertEqual(array.quickSelect(k: 5), 5)
            XCTAssertEqual(array.quickSelect(k: 6), 6)
            XCTAssertEqual(array.quickSelect(k: 7), 7)
            XCTAssertEqual(array.quickSelect(k: 8), 8)
            XCTAssertEqual(array.quickSelect(k: 9), 9)
        }
        do {
            let array = [Int](0..<100).shuffled()
            XCTAssertEqual(array.quickSelect(k: 10), 10)
            XCTAssertEqual(array.quickSelect(k: 20), 20)
            XCTAssertEqual(array.quickSelect(k: 30), 30)
        }
        do {
            let array = [Int](0..<100).shuffled().map(Test.init)
            XCTAssertEqual(array.quickSelect(k: 10), Test(10))
            XCTAssertEqual(array.quickSelect(k: 20), Test(20))
            XCTAssertEqual(array.quickSelect(k: 30), Test(30))
        }
    }
    
}
