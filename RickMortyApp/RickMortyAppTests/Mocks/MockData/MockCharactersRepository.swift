//
//  MockCharactersRepository.swift
//  RickMortyAppTests
//
//  Created by Guido Fabio on 30/5/25.
//

@testable import RickMortyApp
import Foundation

final class MockCharactersRepository: CharactersRepositoryType {
    var fetchCharactersCalled = false
    func fetchCharacters() async -> Result<PageCharactersEntity, CharactersDomainError> {
        fetchCharactersCalled = true
        return .success(.init(characters: [], next: "urlString", prev: nil))
    }
}

final class MockCharactersRepositoryFailure: CharactersRepositoryType {
    var fetchCharactersCalled = false
    var failureError: CharactersDomainError = .generic
    
    func fetchCharacters() async -> Result<PageCharactersEntity, CharactersDomainError> {
        fetchCharactersCalled = true
        return .failure(failureError)
    }
}
