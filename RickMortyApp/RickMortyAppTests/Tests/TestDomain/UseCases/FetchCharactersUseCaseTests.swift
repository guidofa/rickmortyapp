//
//  FetchCharactersUseCaseTests.swift
//  RickMortyAppTests
//
//  Created by Guido Fabio on 28/5/25.
//

import XCTest
@testable import RickMortyApp

final class FetchCharactersUseCaseTests: XCTestCase {
    
    var mockCharactersRepository: MockCharactersRepository!

    var sut: FetchCharactersUseCaseType!
    
    override func setUpWithError() throws {
        self.mockCharactersRepository = MockCharactersRepository()

        self.sut = FetchCharactersUseCase(repository: mockCharactersRepository)
    }

    override func tearDownWithError() throws {
        self.mockCharactersRepository = nil

        self.sut = nil
    }
    
    func test_execute_CallsRepositoryAndReturnsSuccess() async {
        // When
        let result = await sut.execute()
        guard case .success(let page) = result else {
            XCTFail("Expected success, got failure")
            return
        }
        
        // Then
        XCTAssertTrue(mockCharactersRepository.fetchCharactersCalled, "Expected fetchCharacters() to be called")
        XCTAssertEqual(page.characters, [])
    }

    func test_execute_WhenRepositoryFails_PropagatesFailure() async {
        // Given
        let failureMock = MockCharactersRepositoryFailure()
        failureMock.failureError = .generic
        sut = FetchCharactersUseCase(repository: failureMock)

        // When
        let result = await sut.execute()

        // Then
        XCTAssertTrue(failureMock.fetchCharactersCalled, "Expected fetchCharacters() to be called")
        switch result {
        case .success:
            XCTFail("Expected failure, got success")

        case .failure(let error):
            XCTAssertEqual(error, failureMock.failureError)
        }
    }
}
