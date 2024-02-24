import Foundation

// MARK: - CharacterDetailed

struct CharacterDetailed: Decodable, Hashable, Identifiable {
    private enum CodingKeys: CodingKey {
        case id
        case name
        case image
        case status
        case species
        case type
        case gender
        case origin
        case location
        case episode
    }

    init(
        id: String,
        name: String,
        image: URL?,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: Location?,
        location: Location?,
        episodes: [Episode]
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.episodes = episodes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try? container.decode(URL.self, forKey: .image)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.type = try container.decode(String.self, forKey: .type)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.origin = try? container.decodeIfPresent(Location.self, forKey: .origin)
        self.location = try? container.decode(Location.self, forKey: .location)
        self.episodes = (try? container.decode([Episode].self, forKey: .episode)) ?? []
    }

    let id: String
    let name: String
    let image: URL?
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location?
    let location: Location?
    let episodes: [Episode]
}
