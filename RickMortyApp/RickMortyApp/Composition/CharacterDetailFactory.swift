//
//  CharacterDetailFactory.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 4/6/25.
//

import Foundation

protocol CharacterDetailFactoryType {
    func create(character: CharacterEntity) -> CharacterDetailView
}

final class CharacterDetailFactory: CharacterDetailFactoryType {
    func create(character: CharacterEntity) -> CharacterDetailView {
        .init(
            viewModel: createViewModel(character: character)
        )
    }

    private func createViewModel(character: CharacterEntity) -> CharacterDetailViewModel {
        .init(character: character)
    }
}
