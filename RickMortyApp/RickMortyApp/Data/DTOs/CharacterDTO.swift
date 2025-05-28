//
//  CharacterDTO.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

struct CharacterDTO: Codable {
    let id: Int
    let gender: String
    let image: String
    let name: String
    let status: String
}
