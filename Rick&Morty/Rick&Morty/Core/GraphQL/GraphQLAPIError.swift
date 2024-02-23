// MARK: - GraphQLAPIError

enum GraphQLAPIError: Error {
    case errors(messages: [String])
    case unexpected
}
