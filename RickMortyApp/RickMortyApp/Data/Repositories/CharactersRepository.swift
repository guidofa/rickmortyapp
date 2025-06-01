//
//  CharactersRepository.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class CharactersRepository: CharactersRepositoryType {
    
    private let apiDatasource: ApiDatasourceType
    private let charactersDomainMapper: CharactersDomainMapper
    private let errorMapper: CharactersDomainErrorMapper

    init(
        apiDatasource: ApiDatasourceType,
        charactersDomainErrorMapper: CharactersDomainErrorMapper,
        charactersDomainMapper: CharactersDomainMapper
    ) {
        self.apiDatasource = apiDatasource
        self.charactersDomainMapper = charactersDomainMapper
        self.errorMapper = charactersDomainErrorMapper
    }
    
    func fetchCharacters(nextPage: String?) async -> Result<PageCharactersEntity, CharactersDomainError> {
        let pageCharactersResult = await apiDatasource.fetchCharacters(nextPage: nextPage)
        
        guard case .success(let pageCharacters) = pageCharactersResult else {
            return .failure(errorMapper.map(error: pageCharactersResult.failureValue as? HTTPClientErrorEnum))
        }
        
        return .success(
            .init(
                characters: pageCharacters.results.map { charactersDomainMapper.map(character: $0) },
                next: pageCharacters.info.next,
                prev: pageCharacters.info.prev
            )
        )
    }
}
