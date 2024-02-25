// MARK: - Characters

struct Characters: Decodable {
    struct Info: Decodable {
        let next: Int?
    }

    let results: [Character]
    let info: Info
}
