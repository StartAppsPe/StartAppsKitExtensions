import XCTest
@testable import StartAppsKitExtensions

class StartAppsKitExtensionsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(StartAppsKitExtensions().text, "Hello, World!")
    }


    static var allTests : [(String, (StartAppsKitExtensionsTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
