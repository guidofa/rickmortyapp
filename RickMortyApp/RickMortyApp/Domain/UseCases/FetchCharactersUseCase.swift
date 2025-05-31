//
//  FetchCharactersUseCase.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

protocol FetchCharactersUseCaseType {
    func execute() async -> Result<PageCharactersEntity, CharactersDomainError>
}

final class FetchCharactersUseCase: FetchCharactersUseCaseType {
    private let charactersDomainErrorMapper: CharactersDomainErrorMapper
    private let repository: CharactersRepositoryType
    
    init(
        charactersDomainErrorMapper: CharactersDomainErrorMapper,
        repository: CharactersRepositoryType
    ) {
        self.charactersDomainErrorMapper = charactersDomainErrorMapper
        self.repository = repository
    }
    
    func execute() async -> Result<PageCharactersEntity, CharactersDomainError> {
        let result = await repository.fetchCharacters()

        guard let characters = try? result.get() else {
            return .failure(charactersDomainErrorMapper.map(error: result.failureValue as? HTTPClientErrorEnum))
        }

        return .success(characters)
    }
}
