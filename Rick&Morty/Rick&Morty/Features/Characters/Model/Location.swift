
// MARK: - Location

struct Location: Decodable, Hashable, Identifiable {
    let id: String
    let name: String
    let type: String
    let dimension: String
}
