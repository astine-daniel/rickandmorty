// MARK: - HTTPContentType

enum HTTPContentType {
    case json
    case text
}

// MARK: CustomStringConvertible extension

extension HTTPContentType: CustomStringConvertible {

    var description: String {
        switch self {
        case .json:
            return "application/json"
        case .text:
            return "text/plain"
        }
    }
}
