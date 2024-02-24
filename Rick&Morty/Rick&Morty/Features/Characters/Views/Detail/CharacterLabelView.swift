import SwiftUI

// MARK: - CharacterLabelView

struct CharacterLabelView: View {
    let label: String
    let text: String

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.subheadline.bold())

            Text(text)
                .font(.body)
        }
    }
}

// MARK: Preview

#Preview {
    CharacterLabelView(
        label: "Label",
        text: "Some text"
    )
}
