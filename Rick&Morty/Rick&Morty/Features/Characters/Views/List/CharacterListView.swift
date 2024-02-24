import SwiftUI

// MARK: - CharacterListView

struct CharacterListView: View {
    @State var characters: [Character] = []

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(characters) { character in
                    CharacterCardView(image: character.image, name: character.name)
                }
            })
            .padding()
        }
        .navigationTitle("Characters")
        .task {
            await fetchCharacters()
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
    NavigationStack {
        CharacterListView()
    }
}
