import Foundation

// MARK: - CharactersQuery

struct CharactersQuery: GraphQLOperation {

    init(page: Int = 1) {
        self.page = page
    }

    var baseURL: URLConvertible { "https://rickandmortyapi.com/graphql" }
    var operationName: String? { operation }
    var variables: Variables { ["page": page] }
    var query: String {
        """
        query \(operation)($page: Int) {
            characters(page: $page) {
                results {
                    id,
                    name,
                    image
                },
                info {
                    next
                }
            }
        }
        """
    }

    // MARK: Private

    private let page: Int
    private let operation = "GetCharacters"
}
