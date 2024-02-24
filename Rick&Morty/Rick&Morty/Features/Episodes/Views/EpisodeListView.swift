import SwiftUI

// MARK: - EpisodeListView

struct EpisodeListView: View {
    init(episodes: [Episode]) {
        self.episodes = episodes
    }

    var body: some View {
        ExpandableListView(items: episodes) { item in
            EpisodeListItemView(episode: item)
        }
    }

    // MARK: Private

    private let episodes: [Episode]
}

// MARK: Preview

#Preview {
    EpisodeListView(
        episodes: [
            Episode(id: "1", name: "Pilot", airDate: "December 2, 2013", episode: "S01E01"),
            Episode(id: "2", name: "Lawnmower Dog", airDate: "December 9, 2013", episode: "S01E02"),
            Episode(id: "3", name: "Anatomy Park", airDate: "December 16, 2013", episode: "S01E03"),
            Episode(id: "4", name: "M. Night Shaym-Aliens!", airDate: "January, 2014", episode: "S01E04")
        ]
    )
}
