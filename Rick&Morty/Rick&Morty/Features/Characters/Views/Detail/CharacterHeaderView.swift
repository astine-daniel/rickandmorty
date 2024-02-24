import Foundation
import SwiftUI

// MARK: - CharacterHeaderView

struct CharacterHeaderView: View {
    let imageUrl: URL?
    let name: String
    let status: String

    var body: some View {
        HStack {
            VStack {
                AsyncImage(url: imageUrl) { content in
                    content
                        .resizable()
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(.circle)

                Text(name)
                    .font(.title)

                Text(status)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

// MARK: Preview

#Preview {
    CharacterHeaderView(
        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        name: "Rick Sanchez", 
        status: "Alive")
}
