// MARK: - NetworkError

enum NetworkError: Error, Equatable {
    case invalidURL(url: URLConvertible?)
    case unexpected(error: Error)
    case unknown

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case let (.unexpected(lhsError), .unexpected(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
