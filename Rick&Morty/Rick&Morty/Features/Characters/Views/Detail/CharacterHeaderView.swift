import Foundation
import SwiftUI

// MARK: - CharacterHeaderView

struct CharacterHeaderView: View {

    init(imageUrl: URL?, status: String) {
        self.imageUrl = imageUrl
        self.status = status
    }

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
                .frame(minWidth: 200, minHeight: 200)
                .clipShape(.circle)

                Text(status)
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }

    // MARK: Private

    private let imageUrl: URL?
    private let status: String
}

// MARK: Preview

#Preview {
    CharacterHeaderView(
        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        status: "Alive")
}
