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

    init(apiDatasource: ApiDatasourceType, charactersDomainErrorMapper: CharactersDomainErrorMapper, charactersDomainMapper: CharactersDomainMapper) {
        self.apiDatasource = apiDatasource
        self.charactersDomainMapper = charactersDomainMapper
        self.errorMapper = charactersDomainErrorMapper
    }
    
    func fetchCharacters() async -> Result<[CharacterEntity], CharactersDomainError> {
        let pageCharactersResult = await apiDatasource.fetchCharacters()
        
        guard case .success(let pageCharacters) = pageCharactersResult else {
            return .failure(errorMapper.map(error: pageCharactersResult.failureValue as? HTTPClientErrorEnum))
        }

        return .success(pageCharacters.results.map { charactersDomainMapper.map(character: $0) })
    }
}
