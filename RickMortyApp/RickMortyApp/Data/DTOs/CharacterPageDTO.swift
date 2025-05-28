//
//  CharacterPageDTO.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

struct CharacterPageDTO: Codable {
    let results: [CharacterDTO]
    let info: PageInfoDTO
}
