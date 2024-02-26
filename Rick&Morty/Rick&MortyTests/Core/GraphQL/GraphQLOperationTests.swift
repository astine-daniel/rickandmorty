import Foundation
import XCTest

@testable import Rick_Morty

final class GraphQLOperationTests: XCTestCase {
    private struct SimpleGraphQLOperation: GraphQLOperation {
        var baseURL: URLConvertible { "https://rickandmortyapi.com/graphql" }
        var query: String { "" }
    }

    func test_asURLRequest() {
        let operation = SimpleGraphQLOperation()

        var urlRequest: URLRequest?

        assertNoThrows(urlRequest = try operation.asURLRequest())
        assert(urlRequest?.httpMethod, equals: HTTPMethod.post.rawValue)
        assert(urlRequest?.httpBody, notEquals: nil)

        let headerField = urlRequest?.allHTTPHeaderFields?.first
        let expectedHttpHeader: HTTPHeader = .contentType(.json)

        assert(headerField?.key, equals: expectedHttpHeader.name)
        assert(headerField?.value, equals: expectedHttpHeader.value)
    }
}
