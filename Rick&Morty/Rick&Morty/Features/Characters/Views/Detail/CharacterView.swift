import Foundation
import SwiftUI

// MARK: - CharacterView

struct CharacterView: View {
    private enum ViewState: Equatable {
        case loading
        case loaded(character: CharacterDetailed)
        case failed(error: Error)

        static func == (lhs: ViewState, rhs: ViewState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.failed, .failed):
                return true
            case (.loaded, .loaded):
                return true
            default:
                return false
            }
        }
    }

    init(characterId: String, name: String) {
        self.characterId = characterId
        self.name = name
    }

    var body: some View {
        content
            .navigationTitle(name)
            .toolbarRole(.editor)
            .task {
                guard state == .loading else { return }
                await fetchCharacter()
            }
    }

    // MARK: Fileprivate

    fileprivate init(characterId: String, name: String, character: CharacterDetailed) {
        self.init(characterId: characterId, name: name)
        self.state = .loaded(character: character)
    }

    // MARK: Private

    private let api = DefaultGraphQLAPI()

    private let characterId: String
    private let name: String

    @State private var state: ViewState = .loading

    @ViewBuilder
    private var content: some View {
        switch state {
        case .loading:
            characterView(character: nil)
                .redacted(reason: state == .loading ? .placeholder : [])
        case let .loaded(character):
            characterView(character: character)
        case let .failed(error):
            Text(String(describing: error))
        }
    }

    private var loadingView: some View {
        ProgressView()
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

    @MainActor
    private func fetchCharacter() async {
        do {
            let character: CharacterDetailed = try await api.fetch(operation: CharacterByIdQuery(characterId: characterId))
            withAnimation {
                self.state = .loaded(character: character)
            }

        } catch {
            withAnimation {
                self.state = .failed(error: error)
            }
        }
    }
}

// MARK: Preview

#Preview {
    NavigationStack {
        CharacterView(
            characterId: "1",
            name: "Rick Sanchez",
            character: CharacterDetailed(
                id: "1",
                name: "Rick Sanchez",
                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: Location(id: "3", name: "Citadel of Ricks", type: "Space station", dimension: "unknown"),
                location: Location(id: "1", name: "Earth (C-137)", type: "Planet", dimension: "Dimension C-137"),
                episodes: [Episode(id: "1", name: "Pilot", airDate: "December 2, 2013", episode: "S01E01")]
            )
        )
    }
}
