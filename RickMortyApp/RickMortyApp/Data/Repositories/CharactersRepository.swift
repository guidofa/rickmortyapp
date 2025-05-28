//
//  CharactersRepository.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

class CharactersRepository: CharactersRepositoryType {
    
    private let apiDatasource: ApiDatasourceType
    private let charactersDomainMapper: CharactersDomainMapper
    private let errorMapper: CharactersDomainErrorMapper

    var nextPage: String?
    
    init(apiDatasource: ApiDatasourceType, charactersDomainErrorMapper: CharactersDomainErrorMapper, charactersDomainMapper: CharactersDomainMapper) {
        self.apiDatasource = apiDatasource
        self.charactersDomainMapper = charactersDomainMapper
        self.errorMapper = charactersDomainErrorMapper
    }
    
    func fetchCharacters() async -> Result<[CharacterEntity], CharactersDomainError> {
        let pageCharactersResult = await apiDatasource.fetchCharacters()
        
        guard case .success(let pageCharacters) = pageCharactersResult else {
            guard case .failure(let error) = pageCharactersResult else {
                return .failure(.generic)
            }

            return .failure(errorMapper.map(error: error))
        }

        nextPage = pageCharacters.info.next

        return .success(pageCharacters.results.map { charactersDomainMapper.map(character: $0) })
    }
}
