import XCTest

extension XCTestCase {

    func assert<T: Equatable>(
        _ expression: @autoclosure () -> T,
        equals to: T,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(expression(), to, file: file, line: line)
    }

    func assert<T: Equatable>(
        _ expression: @autoclosure () -> T,
        notEquals to: T,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertNotEqual(expression(), to, file: file, line: line)
    }

    func assertTrue(
        _ expression: @autoclosure () -> Bool,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        assert(expression(), equals: true, in: file, line: line)
    }

    func assertFalse(
        _ expression: @autoclosure () -> Bool,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        assert(expression(), equals: false, in: file, line: line)
    }


    func assertNoThrows<T>(
        _ expression: @autoclosure () throws -> T,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertNoThrow(try expression(), file: file, line: line)
    }

    func assert<T, E: Error & Equatable>(
        _ expression: @autoclosure () throws -> T,
        throws error: E,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        var thrownError: Error?

        XCTAssertThrowsError(try expression(), file: file, line: line) {
            thrownError = $0
        }

        XCTAssertTrue(
            thrownError is E,
            "Unexpected error type: \(type(of: thrownError))",
            file: file,
            line: line
        )

        XCTAssertEqual(
            thrownError as? E,
            error,
            file: file,
            line: line
        )
    }
}
