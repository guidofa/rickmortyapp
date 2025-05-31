//
//  CharacterEntity.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

struct CharacterEntity: Equatable, Identifiable {
    let id: Int
    let gender: CharacterGenderEnum
    let imageURL: URL?
    let name: String
    let status: CharacterStatusEnum
}
