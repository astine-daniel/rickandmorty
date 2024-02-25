import Foundation
import SwiftUI

// MARK: - CharacterListRow

struct CharacterListRow: View {

    init(image: URL?, name: String) {
        self.image = image
        self.name = name
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                AsyncImage(url: image) { content in
                    content
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100.0, height: 100.0)

                Text(name)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)

                Spacer()
            }
            .padding()
            .background()
        }
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }

    // MARK: Private

    private let image: URL?
    private let name: String
}

// MARK: Preview

#Preview {
    CharacterListRow(
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        name: "Rick Sanchez"
    )
}
