import Foundation
import XCTest

@testable import Rick_Morty

final class URLRequestConvertibleTests: XCTestCase {

    func test_asURLRequest_from_url_request() {
        let url = URL(string: "https://rickandmortyapi.com/graphql")!
        let urlRequest = URLRequest(url: url)

        assertNoThrows(try urlRequest.asURLRequest())
    }

}
