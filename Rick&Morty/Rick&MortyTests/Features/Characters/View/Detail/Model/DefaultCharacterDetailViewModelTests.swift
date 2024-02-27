import Foundation
import XCTest

@testable import Rick_Morty

@MainActor
final class DefaultCharacterDetailViewModelTests: XCTestCase {
    private var sut: DefaultCharacterDetailViewModel!
    private var apiMock: MockGraphQLAPI!

    override func setUp() {
        super.setUp()

        apiMock = MockGraphQLAPI()
        sut = DefaultCharacterDetailViewModel(clientAPI: apiMock)
    }

    func test_fetchCharacter() async {
        let id = "1"

        let expectedCharacter = makeCharacter(id: id)
        apiMock.fakeReponse = expectedCharacter

        assert(sut.state, equals: .idle)

        await sut.fetchCharacter(id: id)

        apiMock.verifyFetch()
        assert(
            apiMock.requestedOperaction as? CharacterByIdQuery,
            equals: CharacterByIdQuery(characterId: id)
        )

        assert(sut.state, equals: .loaded)
        assert(sut.character, equals: expectedCharacter)
    }

    // MARK: Private

    private func makeCharacter(id: String) -> CharacterDetailed {
        CharacterDetailed(
            id: id,
            name: "Test \(id)",
            image: nil,
            status: "test",
            species: "test",
            type: "test",
            gender: "test",
            origin: nil,
            location: nil,
            episodes: []
        )
    }
}
