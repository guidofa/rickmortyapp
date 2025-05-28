//
//  CharacterPageDTO.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

struct CharacterPageDTO: Codable {
    let results: [CharacterDTO]
    let info: PageInfoDTO
}
