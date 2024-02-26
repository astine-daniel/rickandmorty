@testable import Rick_Morty

final class MockGraphQLAPI: GraphQLAPI, MockVerifier {
    enum MockError: Error {
        case noResultOrWrongResult
    }

    var fakeReponse: Decodable?

    private (set) var requestedOperaction: (any GraphQLOperation)?

    func fetch<Operation, Response>(operation: Operation) async throws -> Response where Operation: GraphQLOperation, Response: Decodable {
        fetchCallCount += 1
        requestedOperaction = operation

        guard let response = fakeReponse as? Response else {
            throw MockError.noResultOrWrongResult
        }

        return response
    }

    func verifyFetch(file: StaticString = #file, line: UInt = #line) {
        verifyMethodCalledOnce(
            methodName: "fetch",
            callCount: fetchCallCount,
            file: file,
            line: line
        )
    }

    func verifyFetchNotCalled(file: StaticString = #file, line: UInt = #line) {
        verifyMethodNeverCalled(
            methodName: "fetch",
            callCount: fetchCallCount,
            file: file,
            line: line
        )
    }

    private var fetchCallCount: Int = 0
}
