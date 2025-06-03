//
//  ApiDatasourceType.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 31/5/25.
//

import Foundation

protocol ApiDatasourceType {
    func fetchCharacters(filterStatus: CharacterStatusEnum, nextPage: String?) async -> Result<CharacterPageDTO, HTTPClientErrorEnum>
}
