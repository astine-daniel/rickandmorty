import Foundation
import XCTest

@testable import Rick_Morty

final class HTTPHeaderTests: XCTestCase {

    func test_content_type() {
        let value = "test"
        let contentType: HTTPContentType = .json

        var header: HTTPHeader = .contentType(value)
        assert(header.name, equals: "Content-Type")
        assert(header.value, equals: value)

        header = .contentType(contentType)
        assert(header.name, equals: "Content-Type")
        assert(header.value, equals: contentType.description)
    }

    func test_url_request_set_header() {
        var urlRequest = URLRequest(url: URL(string: "https://rickandmortyapi.com/graphql")!)
        urlRequest.allHTTPHeaderFields = nil

        let header: HTTPHeader = .contentType(.json)

        urlRequest.set(header: header)
        assert(urlRequest.allHTTPHeaderFields?.count, equals: 1)

        let headerField = urlRequest.allHTTPHeaderFields?.first
        assert(headerField?.key, equals: header.name)
        assert(headerField?.value, equals: header.value)
    }

}
