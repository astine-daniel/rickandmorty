import Foundation

// MARK: - URLConvertible

protocol URLConvertible {
    func asURL() throws -> URL
}

// MARK: String extension

extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.invalidURL(url: self) }
        return try url.asURL()
    }
}

// MARK: URL extension

extension URL: URLConvertible {
    func asURL() throws -> URL {
        guard isFileURL || (host != nil && scheme != nil) else {
            throw NetworkError.invalidURL(url: self)
        }

        return self
    }
}

// MARK: URLComponents extension

extension URLComponents: URLConvertible {
    func asURL() throws -> URL {
        guard let url else { throw NetworkError.invalidURL(url: self) }
        return try url.asURL()
    }
}
