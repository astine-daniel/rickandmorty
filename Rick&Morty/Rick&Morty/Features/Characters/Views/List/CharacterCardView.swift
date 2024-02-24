import Foundation
import SwiftUI

// MARK: - CharacterCardView

struct CharacterCardView: View {

    init(image: URL?, name: String) {
        self.image = image
        self.name = name
    }

    var body: some View {
        VStack {
            AsyncImage(url: image) { content in
                content.resizable()
            } placeholder: {
                ProgressView()
            }
            .overlay(
                Text(name)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .lineLimit(1)
                    .background(.black.opacity(0.7))
                , alignment: .bottom
            )
        }
        .aspectRatio(CGSizeMake(2.0, 3.0), contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }

    // MARK: Private

    private let image: URL?
    private let name: String
}

// MARK: Preview

#Preview {
    CharacterCardView(
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        name: "Rick Sanchez"
    )
}
