import XCTest

@testable import Rick_Morty

final class HTTPContentTypeTests: XCTestCase {

    func test_description_for_json_should_return_correct_description() {
        assert(HTTPContentType.json.description, equals: "application/json")
    }

    func test_description_for_text_should_return_correct_description() {
        assert(HTTPContentType.text.description, equals: "text/plain")
    }
}
