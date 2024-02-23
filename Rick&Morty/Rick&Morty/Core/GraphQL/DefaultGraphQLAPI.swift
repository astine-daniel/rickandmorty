import Dispatch
import Foundation

// MARK: - DefaultGraphQLAPI

struct DefaultGraphQLAPI: GraphQLAPI {

    init(session: URLSessionContract = URLSession.shared) {
        self.session = session
    }

    func fetch<Operation: GraphQLOperation, Response: Decodable>(
        operation: Operation
    ) async throws -> Response {

        let request = try operation.asURLRequest()

        let (data, _) = try await session.data(for: request, delegate: nil)
        let response = try JSONDecoder().decode(GraphQLResponse<Response>.self, from: data)

        switch response.response {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }

    private let session: URLSessionContract
}

// MARK: - GraphQLResponse

private struct GraphQLResponse<T: Decodable>: Decodable {
    private enum CodingKeys: String, CodingKey {
        case data
        case errors
    }

    private struct Data: Decodable {
        let results: T
    }

    private struct Error: Decodable {
        let message: String
    }

    let response: Result<T, GraphQLAPIError>

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let data = try container.decodeIfPresent([String: T].self, forKey: .data), let values = data.values.first {
            response = .success(values)
        } else if let errors = try container.decodeIfPresent([Error].self, forKey: .errors), !errors.isEmpty {
            response = .failure(.errors(messages: errors.map { $0.message }))
        } else {
            response = .failure(.unexpected)
        }
    }
}
