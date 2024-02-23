import Foundation
import SwiftUI

struct CharacterCardView: View {
    let character: Character

    var body: some View {
        VStack {
            AsyncImage(url: character.image) { content in
                content.resizable()
            } placeholder: {
                ProgressView()
            }
            .overlay(
                Text(character.name)
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
}

#Preview {
    CharacterCardView(
        character: Character(
            id: "0",
            name: "Rick Sanchez",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
    )
}
