import SwiftUI

struct CharacterListView: View {

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(0..<9) { _ in
                    CharacterCardView()
                }
            })
            .padding()
        }
        .navigationTitle("Characters")
    }

    private let columns: [GridItem] = [GridItem(), GridItem()]
}

#Preview {
    NavigationStack {
        CharacterListView()
    }
}
