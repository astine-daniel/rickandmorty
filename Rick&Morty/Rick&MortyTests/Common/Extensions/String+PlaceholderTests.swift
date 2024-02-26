import XCTest

@testable import Rick_Morty

final class String_PlaceholderTests: XCTestCase {

    func test_placeholder_should_return_fake_characters_with_correct_length() {
        var placeholder: String = .placeholder()

        assert(placeholder.count, equals: 10)
        assertTrue(placeholder.allSatisfy({ $0 == "X" }))

        placeholder = .placeholder(length: 4)
        assert(placeholder.count, equals: 4)
    }
}
