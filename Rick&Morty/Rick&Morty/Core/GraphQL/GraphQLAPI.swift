import Dispatch

// MARK: - GraphQLAPI

protocol GraphQLAPI {
    func fetch<Operation: GraphQLOperation, Response: Decodable>(
        operation: Operation
    ) async throws -> Response
}
