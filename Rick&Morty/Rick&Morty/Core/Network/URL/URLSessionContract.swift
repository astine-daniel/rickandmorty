import Foundation

// MARK: - URLSessionContract

protocol URLSessionContract {
    func data(
        for request: URLRequest,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

// MARK: URLSession extension

extension URLSession: URLSessionContract { }
