
import XCTest

func XCTAssertEqual<E: Equatable>(_ expression1: [[E]],
                                  _ expression2: [[E]],
                                  file: StaticString = #file,
                                  line: UInt = #line) {
    
    XCTAssertEqual(expression1.count, expression2.count, file: file, line: line)
    
    for (e1, e2) in zip(expression1, expression2) {
        XCTAssertEqual(e1, e2, file: file, line: line)
    }
}

func XCTAssertEqual<E: Equatable>(_ expression1: [ArraySlice<E>],
                                  _ expression2: [ArraySlice<E>],
                                  file: StaticString = #file,
                                  line: UInt = #line) {
    
    XCTAssertEqual(expression1.count, expression2.count, file: file, line: line)
    
    for (e1, e2) in zip(expression1, expression2) {
        XCTAssertEqual(e1, e2, file: file, line: line)
    }
}

func XCTAssertEqual<E: Equatable>(_ expression1: [E]?,
                                  _ expression2: [E]?,
                                  file: StaticString = #file,
                                  line: UInt = #line) {
    
    guard let expression1 = expression1 else {
        XCTAssertNil(expression2, file: file, line: line)
        return
    }
    guard let expression2 = expression2 else {
        XCTFail(file: file, line: line)
        return
    }
    
    XCTAssertEqual(expression1, expression2)
}

func XCTAssertEqual<E: Equatable>(_ expression1: ArraySlice<E>?,
                                  _ expression2: ArraySlice<E>?,
                                  file: StaticString = #file,
                                  line: UInt = #line) {
    
    guard let expression1 = expression1 else {
        XCTAssertNil(expression2, file: file, line: line)
        return
    }
    guard let expression2 = expression2 else {
        XCTFail(file: file, line: line)
        return
    }
    
    XCTAssertEqual(expression1, expression2)
}
