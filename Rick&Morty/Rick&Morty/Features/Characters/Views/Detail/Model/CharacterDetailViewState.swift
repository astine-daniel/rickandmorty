
// MARK: - CharacterDetailViewState

enum CharacterDetailViewState: Equatable {
    case idle
    case loading
    case loaded
    case failure(error: Error)

    static func == (lhs: CharacterDetailViewState, rhs: CharacterDetailViewState) -> Bool {
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
