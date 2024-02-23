import Foundation

// MARK: - Character

struct Character: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let image: URL?
}
