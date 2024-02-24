import Foundation
import SwiftUI

// MARK: - CharacterView

struct CharacterView: View {
    init(character: CharacterDetailed) {
        self.character = character
    }

    var body: some View {
        Form {
            CharacterHeaderView(
                imageUrl: character.image,
                name: character.name,
                status: character.status
            )

            Section("Informations") {
                CharacterLabelView(label: "Species", text: character.species)
                CharacterLabelView(label: "Gender", text: character.gender)
                CharacterLabelView(label: "Type", text: character.type.isEmpty ? "-" : character.type)
            }

            Section("Current Location") {
                CharacterLabelView(label: "Name", text: character.location.name)
                CharacterLabelView(label: "Type", text: character.location.type)
                CharacterLabelView(label: "Dimension", text: character.location.dimension)
            }

            Section("Origin") {
                CharacterLabelView(label: "Name", text: character.origin.name)
                CharacterLabelView(label: "Type", text: character.origin.type)
                CharacterLabelView(label: "Dimension", text: character.origin.dimension)
            }

            Section("Episodes") {
                EpisodeListView(episodes: character.episodes)
            }
        }
    }

    // MARK: Private

    private let character: CharacterDetailed
}

// MARK: Preview

#Preview {
    CharacterView(
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
