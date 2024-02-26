import Foundation

// MARK: - HTTPMethod

enum HTTPMethod: String, CaseIterable {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
}

// MARK: - URLRequest extension

extension URLRequest {
    mutating func set(httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod.rawValue
    }
}
