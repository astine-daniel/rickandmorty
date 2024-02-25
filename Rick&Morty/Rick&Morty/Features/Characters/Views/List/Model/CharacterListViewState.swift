
// MARK: - CharacterListViewState

enum CharacterListViewState: Equatable {
    case idle
    case loading
    case loaded
    case failure(error: Error)

    static func == (lhs: CharacterListViewState, rhs: CharacterListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case let (.failure(lhsError), .failure(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
