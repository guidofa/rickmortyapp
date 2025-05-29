//
//  CharacterUIModel.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

struct CharacterUIModel: Identifiable {
    let id: Int
    let imageURL: URL?
    let name: String
    let status: CharacterStatus
    let gender: String

    init(domainModel: CharacterEntity) {
        self.id = domainModel.id
        self.imageURL = domainModel.imageURL
        self.name = domainModel.name
        self.status = domainModel.status
        self.gender = domainModel.gender
    }
}
