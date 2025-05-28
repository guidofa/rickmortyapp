//
//  FeatchCharactersUseCase.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class FeatchCharactersUseCase {
    private let repository: CharactersRepositoryType
    
    init(repository: CharactersRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CharacterEntity], CharactersDomainError> {
        let result = await repository.fetchCharacters()

        guard let characters = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(characters)
    }
}
