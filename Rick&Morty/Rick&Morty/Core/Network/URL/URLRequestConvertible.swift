import Foundation

// MARK: - URLRequestConvertible

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

// MARK: URLRequest extension

extension URLRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest { self }
}
