//
//  CharactersRepositoryTests.swift
//  RickMortyAppTests
//
//  Created by Guido Fabio on 31/5/25.
//

import XCTest
@testable import RickMortyApp

final class CharactersRepositoryTests: XCTestCase {
    
    var mockApiDataSource: MockApiDatasource!

    var sut: CharactersRepository!

    override func setUpWithError() throws {
        self.mockApiDataSource = MockApiDatasource()

        self.sut = CharactersRepository(
            apiDatasource: mockApiDataSource,
            charactersDomainErrorMapper: .init(),
            charactersDomainMapper: .init()
        )
    }

    override func tearDownWithError() throws {
        self.mockApiDataSource = nil

        self.sut = nil
    }


    func testFetchCharacters_whenApiReturnsSuccess_mapsToPageCharactersEntity() async {
        // When
        let result = await sut.fetchCharacters()
        guard case .success(let page) = result else {
            XCTFail("Expected success, got failure")
            return
        }
        
        // Then
        XCTAssertTrue(mockApiDataSource.fetchCharactersCalled, "Expected fetchCharacters() to be called")
        XCTAssertEqual(page.characters, [], "Expected [] characters")
    }

    func testFetchCharacters_whenApiReturnsFailure_propagatesFailure() async {
        // Given
        let failureMock = MockApiDatasourceFailure()

        self.sut = CharactersRepository(
            apiDatasource: failureMock,
            charactersDomainErrorMapper: .init(),
            charactersDomainMapper: .init()
        )

        // When
        let result = await sut.fetchCharacters()
        
        // Then
        XCTAssertTrue(failureMock.fetchCharactersCalled, "Expected fetchCharacters() to be called")
        switch result {
        case .success:
            XCTFail("Expected failure, got success")

        case .failure(let error):
            XCTAssertEqual(error, .generic)
        }
    }
}
