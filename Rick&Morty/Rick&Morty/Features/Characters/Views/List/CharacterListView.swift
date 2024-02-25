import SwiftUI

// MARK: - CharacterListView

struct CharacterListView<ViewModel: CharacterListViewModel>: View {
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .onOrientationChanged { orientation in
                withAnimation {
                    self.orientation = orientation
                }
            }
            .animation(.default, value: viewModel.state)
            .animation(.default, value: viewModel.characters)
            .task {
                guard viewModel.state == .idle else { return }
                await viewModel.fetchCharacters()
            }
    }

    // MARK: Private

    @StateObject private var viewModel: ViewModel
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation

    private var columns: [GridItem] {
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            return [GridItem(), GridItem()]
        default:
            return [GridItem()]
        }
    }

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
                                CharacterListRow(image: character.image, name: character.name)
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
