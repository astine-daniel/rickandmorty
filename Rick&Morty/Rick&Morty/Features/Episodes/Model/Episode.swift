import Foundation

// MARK: - Episode

struct Episode: Decodable, Hashable, Identifiable {
    let id: String
    let name: String
    let airDate: String
    let episode: String
}
