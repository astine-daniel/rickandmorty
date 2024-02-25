import Foundation

// MARK: - CharacterListViewModel

@MainActor
protocol CharacterListViewModel: ObservableObject {
    var state: CharacterListViewState { get }
    var characters: [Character] { get }

    func shouldFetchMoreCharacters(currentIndex: Int) -> Bool

    func fetchCharacters() async
    func fetchMoreCharacters() async
}

// MARK: - DefaultCharacterListViewModel

final class DefaultCharacterListViewModel: CharacterListViewModel {
    @Published private (set) var state: CharacterListViewState = .idle
    private (set) var characters: [Character] = [] {
        willSet {
            guard isFetchingNextPage else { return }
            objectWillChange.send()
        }
    }

    init(clientAPI: GraphQLAPI = DefaultGraphQLAPI(), thresholdToFetchMore: Int = 3) {
        self.clientAPI = clientAPI
        self.thresholdToFetchMore = thresholdToFetchMore
    }

    func shouldFetchMoreCharacters(currentIndex: Int) -> Bool {
        guard canFetchNextPage else { return false }

        return currentIndex >= characters.endIndex - thresholdToFetchMore
    }

    func fetchCharacters() async {
        do {
            state = .loading

            let characters: Characters = try await clientAPI.fetch(operation: CharactersQuery())
            self.characters = characters.results

            nextPage = characters.info.next

            state = .loaded

        } catch {
            state = .failure(error: error)
        }
    }

    func fetchMoreCharacters() async {
        guard canFetchNextPage, let nextPage else { return }

        isFetchingNextPage = true

        do {
            let characters: Characters = try await clientAPI.fetch(operation: CharactersQuery(page: nextPage))
            self.characters.append(contentsOf: characters.results)
            self.nextPage = characters.info.next

            isFetchingNextPage = false
        } catch {
            // Since we are trying to load more items and we receive an error,
            // we are ignoring this error and preventing the loading more function.
            self.nextPage = nil
        }
    }

    // MARK: Private

    private let clientAPI: GraphQLAPI

    private var thresholdToFetchMore: Int
    private var isFetchingNextPage: Bool = false
    private var nextPage: Int?

    private var canFetchNextPage: Bool {
        !isFetchingNextPage && nextPage != nil
    }
}
