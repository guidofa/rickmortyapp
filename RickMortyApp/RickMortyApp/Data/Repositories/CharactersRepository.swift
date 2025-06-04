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
    private let inMemoryCache: InMemoryCacheType

    init(
        apiDatasource: ApiDatasourceType,
        charactersDomainErrorMapper: CharactersDomainErrorMapper,
        charactersDomainMapper: CharactersDomainMapper,
        inMemoryCache: InMemoryCacheType
    ) {
        self.apiDatasource = apiDatasource
        self.charactersDomainMapper = charactersDomainMapper
        self.errorMapper = charactersDomainErrorMapper
        self.inMemoryCache = inMemoryCache
    }
    
    func fetchCharacters(filterStatus: CharacterStatusEnum, nextPage: String?) async -> Result<PageCharactersEntity, CharactersDomainError> {
        let pageToSave = nextPage ?? filterStatus.rawValue

        if let result = await inMemoryCache.getCharactersPage(page: pageToSave) {
            return .success(result)
        }
        
        let pageCharactersResult = await apiDatasource.fetchCharacters(filterStatus: filterStatus, nextPage: nextPage)
        
        guard case .success(let pageCharacters) = pageCharactersResult else {
            return .failure(errorMapper.map(error: pageCharactersResult.failureValue as? HTTPClientErrorEnum))
        }
        
        let pageEntity: PageCharactersEntity = .init(
            characters: pageCharacters.results.map { charactersDomainMapper.map(character: $0) },
            next: pageCharacters.info.next,
            prev: pageCharacters.info.prev
        )
        
        await inMemoryCache
            .setCharactersPage(
                characters: pageEntity,
                page: pageToSave
            )
        
        return .success(pageEntity)
    }
}
