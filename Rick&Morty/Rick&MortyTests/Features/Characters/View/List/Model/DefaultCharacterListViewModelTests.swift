import Foundation
import XCTest

@testable import Rick_Morty

@MainActor
final class DefaultCharacterListViewModelTests: XCTestCase {
    private var sut: DefaultCharacterListViewModel!
    private var apiMock: MockGraphQLAPI!

    override func setUp() {
        super.setUp()

        apiMock = MockGraphQLAPI()
        sut = DefaultCharacterListViewModel(clientAPI: apiMock)
    }

    func test_fetchCharacters() async {
        let expectedCharacters = makeCharactersResponse()
        apiMock.fakeReponse = expectedCharacters

        assert(sut.state, equals: .idle)

        await sut.fetchCharacters()

        apiMock.verifyFetch()
        assert(apiMock.requestedOperaction as? CharactersQuery, equals: CharactersQuery())

        assert(sut.state, equals: .loaded)
        assert(sut.characters, equals: expectedCharacters.results)
    }

    func test_shouldFetchMoreCharacters() async {
        let possibilities: [(response: Characters, currentIndex: Int, expectedResult: Bool)] = [
            (response: makeCharactersResponse(), currentIndex: 7, expectedResult: true),
            (response: makeCharactersResponse(), currentIndex: 6, expectedResult: false),
            (response: makeCharactersResponse(nextPage: nil), currentIndex: 7, expectedResult: false)
        ]

        for possibility in possibilities {
            apiMock.fakeReponse = possibility.response
            await sut.fetchCharacters()
            assert(sut.shouldFetchMoreCharacters(currentIndex: possibility.currentIndex), equals: possibility.expectedResult)
        }
    }

    func test_fetchMoreCharacters() async {
        let firstPageCharacters = makeCharactersResponse(firstCharacterIndex: 1, numberOfCharacters: 10, nextPage: 2)
        apiMock.fakeReponse = firstPageCharacters
        await sut.fetchCharacters()

        let secondPageCharacters = makeCharactersResponse(firstCharacterIndex: 11)
        apiMock.fakeReponse = secondPageCharacters

        let expectedCharacters = firstPageCharacters.results + secondPageCharacters.results
        await sut.fetchMoreCharacters()

        assert(apiMock.requestedOperaction as? CharactersQuery, equals: CharactersQuery(page: 2))
        assert(sut.characters, equals: expectedCharacters)
    }

    private func makeCharactersResponse(firstCharacterIndex: Int = 1, numberOfCharacters: Int = 10, nextPage: Int? = 2) -> Characters {
        Characters(
            results: makeCharactersList(firstIndex: firstCharacterIndex, total: numberOfCharacters),
            info: Characters.Info(next: nextPage)
        )
    }

    private func makeCharactersList(firstIndex: Int, total: Int) -> [Character] {
        (0 ..< total).map { index in
            let id = "\(firstIndex + index)"
            return Character(id: id, name: "Test \(id)", image: nil)
        }
    }
}
