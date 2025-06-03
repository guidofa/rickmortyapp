//
//  CharactersRepositoryType.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

protocol CharactersRepositoryType {
    func fetchCharacters(filterStatus: CharacterStatusEnum, nextPage: String?) async -> Result<PageCharactersEntity, CharactersDomainError>
}
