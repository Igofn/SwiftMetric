import Foundation
import XCTest
@testable import SwiftMetric

class NumberOfChildrenMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure1() {
        let sourceFile1 = SourceFile(path: "A.swift", content: "class A { }")
        let sourceFile2 = SourceFile(path: "B.swift", content: "class B: A { }; class C: A { }")
        let files = [sourceFile1, sourceFile2]
        let results = NumberOfChildrenMetric(files).measure()

        XCTAssertEqual(results.count, 3)

        let result1 = results[0]
        let result2 = results[1]
        let result3 = results[2]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 2)
//        XCTAssertEqual(result1.path, "A.swift")

        XCTAssertEqual(result2.className, "B")
        XCTAssertEqual(result2.value, 0)
//        XCTAssertEqual(result2.path, "B.swift")

        XCTAssertEqual(result3.className, "C")
        XCTAssertEqual(result3.value, 0)
//        XCTAssertEqual(result3.path, "B.swift")
    }

    func testMeasure2() {
        let sourceFile1 = SourceFile(path: "A.swift", content: "class A { }")
        let sourceFile2 = SourceFile(path: "B.swift", content: "class B: A { }; class C: B { }")
        let files = [sourceFile1, sourceFile2]
        let results = NumberOfChildrenMetric(files).measure()

        XCTAssertEqual(results.count, 3)

        let result1 = results[0]
        let result2 = results[1]
        let result3 = results[2]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 1)
        //        XCTAssertEqual(result1.path, "A.swift")

        XCTAssertEqual(result2.className, "B")
        XCTAssertEqual(result2.value, 1)
        //        XCTAssertEqual(result2.path, "B.swift")

        XCTAssertEqual(result3.className, "C")
        XCTAssertEqual(result3.value, 0)
        //        XCTAssertEqual(result3.path, "B.swift")
    }

    
}
