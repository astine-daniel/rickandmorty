import Foundation
import XCTest

@testable import Rick_Morty

final class DefaultGraphQLAPITests: XCTestCase {
    private var sut: DefaultGraphQLAPI!
    private var sessionMock: MockSession!

    // MARK: Setup

    override func setUp() {
        super.setUp()

        sessionMock = MockSession()
        sut = DefaultGraphQLAPI(session: sessionMock)
    }

    // MARK: Tests

    func test_fetch_operation() async throws {
        sessionMock.fakeData = makeFakeData()
        sessionMock.fakeURLResponse = URLResponse()

        let operation = CharactersQuery()
        let expectedRequest = try operation.asURLRequest()
        let expectedCharacters = Characters(
            results: [
                Character(
                    id: "1",
                    name: "Rick Sanchez",
                    image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
                )
            ],
            info: Characters.Info(next: nil)
        )

        let characters: Characters = try await sut.fetch(operation: operation)

        sessionMock.verifyDataFor()
        assert(sessionMock.requestedReceived, equals: expectedRequest)
        assert(characters, equals: expectedCharacters)
    }

    // MARK: Private

    private func makeFakeData() -> Data {
        let jsonString = """
        {
          "data": {
            "characters": {
              "results": [
                {
                  "id": "1",
                  "name": "Rick Sanchez",
                  "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
                }
               ],
               "info": {
                 "next": null
               }
            }
          }
        }
        """

        return jsonString.data(using: .utf8)!
    }
}

// MARK: Mock

private final class MockSession: URLSessionContract, MockVerifier {
    enum MockError: Error {
        case noResult
    }

    var fakeData: Data?
    var fakeURLResponse: URLResponse?

    private (set) var requestedReceived: URLRequest?
    private (set) var delegateReceived: URLSessionTaskDelegate?

    func verifyDataFor(file: StaticString = #file, line: UInt = #line) {
        verifyMethodCalledOnce(
            methodName: "data(for:)",
            callCount: dataForCallCount,
            file: file,
            line: line
        )
    }

    func verifyDataForNotCalled(file: StaticString = #file, line: UInt = #line) {
        verifyMethodNeverCalled(
            methodName: "data(for:)",
            callCount: dataForCallCount,
            file: file,
            line: line
        )
    }

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        self.dataForCallCount += 1
        self.requestedReceived = request
        self.delegateReceived = delegate

        guard let fakeData, let fakeURLResponse else {
            throw MockError.noResult
        }

        return (fakeData, fakeURLResponse)
    }

    private var dataForCallCount: Int = 0
}
