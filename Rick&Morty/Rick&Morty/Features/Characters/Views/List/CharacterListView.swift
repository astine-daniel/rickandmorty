import SwiftUI

// MARK: - CharacterListView

struct CharacterListView: View {
    @State var characters: [Character] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(characters) { character in
                        NavigationLink(
                            value: character,
                            label: {
                                CharacterCardView(image: character.image, name: character.name)
                            }
                        )
                    }
                })
                .padding()
            }
            .navigationTitle("Characters")
            .navigationDestination(for: Character.self) { character in
                CharacterView(characterId: character.id, name: character.name)
            }
            .task {
                await fetchCharacters()
            }
        }
    }

    // MARK: Private

    private let api = DefaultGraphQLAPI()

    @MainActor
    private func fetchCharacters() async {
        do {
            let characters: Characters = try await api.fetch(operation: CharactersQuery())
            self.characters = characters.results

        } catch {
            print("Error: \(String(describing: error))")
        }
    }

    private let columns: [GridItem] = [GridItem(), GridItem()]
}

// MARK: Preview

#Preview {
    CharacterListView()
}
