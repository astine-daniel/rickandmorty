import Foundation
import XCTest

@testable import Rick_Morty

final class URLConvertibleTests: XCTestCase {

    func test_asURL_from_string() {
        let invalidURLString = "not a URL"
        assert(try invalidURLString.asURL(), throws: NetworkError.invalidURL(url: invalidURLString))

        let validURL = "https://rickandmortyapi.com/graphql"
        assertNoThrows(try validURL.asURL())
    }

    func test_asURL_from_url() {
        let validURL = URL(string: "https://rickandmortyapi.com/graphql")
        assertNoThrows(try validURL?.asURL())

        let validFileURL = URL(string: "file://path/")
        assertNoThrows(try validFileURL?.asURL())

        let invalidURL = URL(string: "rickandmortyapi.com")
        assert(try invalidURL?.asURL(), throws: NetworkError.invalidURL(url: invalidURL))
    }

    func test_asURL_from_url_components() {
        var urlComponents = URLComponents()
        assert(try urlComponents.asURL(), throws: NetworkError.invalidURL(url: urlComponents))

        urlComponents.scheme = "https"
        urlComponents.host = "rickandmortyapi.com"

        assertNoThrows(try urlComponents.asURL())
    }
}
