import Foundation

// MARK: - HTTPHeader

struct HTTPHeader: Hashable {
    let name: String
    let value: String?
}

// MARK: Default headers

extension HTTPHeader {
    static func contentType(_ value: String?) -> HTTPHeader {
        HTTPHeader(name: .contentType, value: value)
    }

    static func contentType(_ value: HTTPContentType) -> HTTPHeader {
        contentType(value.description)
    }
}

// MARK: Private extension

private extension HTTPHeader {

    enum Name: String {
        case contentType = "Content-Type"
    }

    init(name: HTTPHeader.Name, value: String?) {
        self.name = name.rawValue
        self.value = value
    }
}

// MARK: - URLRequest extension

extension URLRequest {

    mutating func set(header: HTTPHeader) {
        setValue(header.value, forHTTPHeaderField: header.name)
    }

}
