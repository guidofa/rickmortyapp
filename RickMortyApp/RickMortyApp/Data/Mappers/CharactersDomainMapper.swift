//
//  CharactersDomainMapper.swift.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class CharactersDomainMapper {
    func map(character: CharacterDTO) -> CharacterEntity {
        .init(
            id: character.id,
            gender: character.gender,
            imageURL: URL(string: character.image),
            name: character.name,
            status: CharacterStatusEnum(rawValue: character.status) ?? .unknown
        )
    }
}
