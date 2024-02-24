extension String {
    static func placeholder(length: Int = 10) -> String {
        String(Array(repeating: "X", count: length))
    }
}
