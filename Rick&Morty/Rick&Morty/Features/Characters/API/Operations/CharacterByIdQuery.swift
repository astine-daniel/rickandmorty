import Foundation

// MARK: - CharactersQuery

struct CharacterByIdQuery: GraphQLOperation {

    init(characterId: String) {
        self.characterId = characterId
    }

    var baseURL: URLConvertible { "https://rickandmortyapi.com/graphql" }
    var operationName: String? { operation }
    var variables: Variables { ["id": characterId] }

    var query: String {
        """
        query \(operation)($id: ID!) {
            character(id: $id) {
                id,
                name,
                image,
                status,
                species,
                type,
                gender,
                origin {
                    id,
                    name,
                    type,
                    dimension
                },
                location {
                    id,
                    name,
                    type,
                    dimension
                }
                episode {
                    id,
                    name,
                    air_date,
                    episode,
                    created
                }
            }
        }
        """
    }

    // MARK: Private

    private let characterId: String
    private let operation = "GetCharacterById"
}
