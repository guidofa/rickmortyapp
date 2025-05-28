//
//  DataSourceType.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

protocol ApiDatasourceType {
    func  fetchCharacters() async -> Result<CharacterPageDTO, HTTPClientError>
}
