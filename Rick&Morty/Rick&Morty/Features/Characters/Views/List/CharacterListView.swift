import SwiftUI

// MARK: - CharacterListView

struct CharacterListView<ViewModel: CharacterListViewModel>: View {
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .animation(.default, value: viewModel.state)
            .animation(.default, value: viewModel.characters)
            .task {
                guard viewModel.state == .idle else { return }
                await viewModel.fetchCharacters()
            }
    }

    // MARK: Private

    private let columns: [GridItem] = [GridItem(), GridItem()]

    @StateObject private var viewModel: ViewModel

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case let .failure(error):
            errorViewFor(error)
        case .loaded:
            characterListView
        }
    }

    private var characterListView: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(Array(viewModel.characters.enumerated()), id: \.element) { (index, character) in
                        NavigationLink(
                            value: character,
                            label: {
                                CharacterCardView(image: character.image, name: character.name)
                                    .onAppear {
                                        guard viewModel.shouldFetchMoreCharacters(currentIndex: index) else { return }
                                        Task {
                                            await viewModel.fetchMoreCharacters()
                                        }
                                    }
                            }
                        )
                    }
                })
                .padding()
            }
            .navigationTitle("Characters")
            .navigationDestination(for: Character.self) { character in
                CharacterDetailView(
                    characterId: character.id,
                    name: character.name,
                    viewModel: DefaultCharacterDetailViewModel()
                )
            }
        }
    }

    private func errorViewFor(_ error: Error) -> some View {
        return ErrorView(error: error) {
            Task {
                await viewModel.fetchCharacters()
            }
        }
    }
}

// MARK: Preview

#Preview {
    CharacterListView(viewModel: DefaultCharacterListViewModel())
}
