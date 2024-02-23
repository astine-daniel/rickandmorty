// MARK: - NetworkError

enum NetworkError: Error {
    case invalidURL(url: URLConvertible)
    case unexpected(error: Error)
    case unknown
}
