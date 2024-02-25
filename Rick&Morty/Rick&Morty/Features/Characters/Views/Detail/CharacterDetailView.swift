import Foundation
import SwiftUI

// MARK: - CharacterDetailView

struct CharacterDetailView<ViewModel: CharacterDetailViewModel>: View {
    init(characterId: String, name: String, viewModel: ViewModel) {
        self.characterId = characterId
        self.name = name

        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle(name)
            .toolbarRole(.editor)
            .animation(.default, value: viewModel.state)
            .task {
                guard viewModel.state == .idle else { return }
                await viewModel.fetchCharacter(id: characterId)
            }
    }

    // MARK: Private

    private let characterId: String
    private let name: String

    @StateObject private var viewModel: ViewModel

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading, .idle:
            characterView(character: nil)
                .redacted(reason: viewModel.state == .loading ? .placeholder : [])
        case .loaded:
            characterView(character: viewModel.character)
        case let .failure(error):
            Text(String(describing: error))
        }
    }

    private func characterView(character: CharacterDetailed?) -> some View {
        Form {
            CharacterHeaderView(
                imageUrl: character?.image,
                status: character?.status ?? .placeholder()
            )

            Section("Informations") {
                CharacterLabelView(label: "Name", text: character?.name ?? .placeholder())
                CharacterLabelView(label: "Species", text: character?.species ?? .placeholder())
                CharacterLabelView(label: "Gender", text: character?.gender ?? .placeholder())
                CharacterLabelView(label: "Type", text: character?.type.isEmpty == true ? "-" : (character?.type ?? .placeholder()))
            }

            if let location = character?.location {
                Section("Current Location") {
                    CharacterLabelView(label: "Name", text: location.name)
                    CharacterLabelView(label: "Type", text: location.type)
                    CharacterLabelView(label: "Dimension", text: location.dimension)
                }
            }

            if let origin = character?.origin {
                Section("Origin") {
                    CharacterLabelView(label: "Name", text: origin.name)
                    CharacterLabelView(label: "Type", text: origin.type)
                    CharacterLabelView(label: "Dimension", text: origin.dimension)
                }
            }

            if character?.episodes.isEmpty == false {
                Section("Episodes") {
                    EpisodeListView(episodes: character?.episodes ?? [])
                }
            }
        }
    }
}

// MARK: Preview

#Preview {
    NavigationStack {
        CharacterDetailView(
            characterId: "1",
            name: "Rick Sanchez",
            viewModel: DefaultCharacterDetailViewModel()
        )
    }
}
