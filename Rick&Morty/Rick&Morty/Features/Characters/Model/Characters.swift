// MARK: - Characters

struct Characters: Hashable, Decodable {
    struct Info: Hashable, Decodable {
        let next: Int?
    }

    let results: [Character]
    let info: Info
}
