//
//  CharacterDetailViewModel.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 4/6/25.
//

import Foundation

final class CharacterDetailViewModel: ObservableObject {
    @Published var character: CharacterEntity

    init(character: CharacterEntity) {
        self.character = character
    }
}
