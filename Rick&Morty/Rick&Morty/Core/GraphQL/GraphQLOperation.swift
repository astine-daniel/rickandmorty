import Foundation

// MARK: - GraphQLOperation

protocol GraphQLOperation: Hashable, URLRequestConvertible {
    typealias Variables = [String: Encodable]

    var baseURL: URLConvertible { get }

    var operationName: String? { get }
    var variables: Variables { get }
    var query: String { get }
}

// MARK: Default

extension GraphQLOperation {
    var variables: Variables { [:] }
    var operationName: String? { nil }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()

        var urlRequest = URLRequest(url: url)

        urlRequest.set(httpMethod: .post)
        urlRequest.set(header: .contentType(.json))
        urlRequest.httpBody = try JSONEncoder().encode(GraphQLRequest(operation: self))

        return urlRequest
    }
}

private struct GraphQLRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case operationName
        case variables
        case query
    }

    init<T: GraphQLOperation>(operation: T) {
        self.operationName = operation.operationName
        self.variables = operation.variables
        self.query = operation.query
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(operationName, forKey: .operationName)
        try container.encode(query, forKey: .query)
        try container.encode(variables, forKey: .variables)
    }

    let operationName: String?
    let variables: [String: Encodable]
    let query: String
}

private extension KeyedEncodingContainer {
    struct JSONCodingKeys: CodingKey {
        let stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            self.init(stringValue: "\(intValue)")
            self.intValue = intValue
        }
    }

    mutating func encode(
        _ value: [String: Encodable],
        forKey key: KeyedEncodingContainer<K>.Key
    ) throws {

        guard !value.isEmpty else { return }

        var container = nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        try value.forEach { key, encodableValue in
            guard let key = JSONCodingKeys(stringValue: key) else { return }
            try container.encodeIfPresent(encodableValue, forKey: key)
        }
    }
}
