import XCTest

@testable import Rick_Morty

final class NetworkErrorTests: XCTestCase {
    private enum SomeError: Error {
        case error1
        case error2
    }

    func test_equals() {
        let equalCombinations: [(NetworkError, NetworkError)] = [
            (.unknown, .unknown),
            (.invalidURL(url: nil), .invalidURL(url: nil)),
            (.unexpected(error: SomeError.error1), .unexpected(error: SomeError.error1))
        ]

        equalCombinations.forEach { combination in
            assert(combination.0, equals: combination.1)
        }

        let noEqualCombinations: [(NetworkError, NetworkError)] = [
            (.unknown, .invalidURL(url: nil)),
            (.unknown, .unexpected(error: SomeError.error1)),
            (.invalidURL(url: nil), .unknown),
            (.invalidURL(url: nil), .unexpected(error: SomeError.error1)),
            (.unexpected(error: SomeError.error1), .unexpected(error: SomeError.error2))
        ]

        noEqualCombinations.forEach { combination in
            assert(combination.0, notEquals: combination.1)
        }
    }
}
