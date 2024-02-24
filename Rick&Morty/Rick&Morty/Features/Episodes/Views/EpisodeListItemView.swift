import SwiftUI

// MARK: - EpisodeListItemView

struct EpisodeListItemView: View {

    init(episode: Episode) {
        self.episode = episode
    }

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(episode.episode)
                    .font(.headline)
                Text(episode.name)
                    .font(.body)
            }
            .foregroundStyle(.primary)

            Spacer()

            Text(episode.airDate)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }

    // MARK: Private

    private let episode: Episode
}

// MARK: Preview

#Preview {
    EpisodeListItemView(
        episode: Episode(id: "1", name: "Pilot", airDate: "December 2, 2013", episode: "S01E01")
    )
}
