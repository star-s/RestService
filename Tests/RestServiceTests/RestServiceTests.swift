import XCTest
@testable import RestService

final class RestServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(RestService().text, "Hello, World!")
    }

	func testEmptyDataDecodedWithWrapping() {
		XCTAssertNoThrow(try JSONDecoder().decodeWithWrapping(NullValue.self, from: Data()))
	}
	
    static var allTests = [
        ("testExample", testExample),
		("emptyDataDecodedWithWrapping", testEmptyDataDecodedWithWrapping),
    ]
}
