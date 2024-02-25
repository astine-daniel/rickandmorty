import Foundation

// MARK: - CharacterDetailViewModel

@MainActor
protocol CharacterDetailViewModel: ObservableObject {
    var state: CharacterDetailViewState { get }
    var character: CharacterDetailed? { get }

    func fetchCharacter(id: String) async
}

// MARK: - DefaultCharacterDetailViewModel

final class DefaultCharacterDetailViewModel: CharacterDetailViewModel {
    @Published private (set) var state: CharacterDetailViewState = .idle
    private (set) var character: CharacterDetailed? = nil

    init(clientAPI: GraphQLAPI = DefaultGraphQLAPI()) {
        self.clientAPI = clientAPI
    }

    func fetchCharacter(id: String) async {
        state = .loading

        do {
            let character: CharacterDetailed = try await clientAPI.fetch(
                operation: CharacterByIdQuery(characterId: id)
            )

            self.character = character

            state = .loaded
        } catch {
            state = .failure(error: error)
        }
    }

    // MARK: Private

    private let clientAPI: GraphQLAPI
}
