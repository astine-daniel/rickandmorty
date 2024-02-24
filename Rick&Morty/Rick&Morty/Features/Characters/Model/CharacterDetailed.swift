import Foundation

// MARK: - CharacterDetailed

struct CharacterDetailed: Decodable, Hashable, Identifiable {
    let id: String
    let name: String
    let image: URL?
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let episodes: [Episode]
}
