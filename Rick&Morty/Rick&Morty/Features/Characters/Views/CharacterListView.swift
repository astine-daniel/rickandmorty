import SwiftUI

struct CharacterListView: View {
    let api = DefaultGraphQLAPI()
    @State var characters: [Character] = []

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(characters) { character in
                    CharacterCardView(character: character)
                }
            })
            .padding()
        }
        .navigationTitle("Characters")
        .task {
            await fetchCharacters()
        }
    }

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

#Preview {
    NavigationStack {
        CharacterListView()
    }
}
