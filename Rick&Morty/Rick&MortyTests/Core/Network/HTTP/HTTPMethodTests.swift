import Foundation
import XCTest

@testable import Rick_Morty

final class HTTPMethodTests: XCTestCase {

    func test_url_request_set_http_method() {
        var urlRequest = URLRequest(url: URL(string: "https://rickandmortyapi.com/graphql")!)
        urlRequest.httpMethod = nil

        HTTPMethod.allCases.forEach {
            urlRequest.set(httpMethod: $0)
            assert(urlRequest.httpMethod, equals: $0.rawValue)
        }
    }
}
