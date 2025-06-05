//
//  FavoritesStateHolder.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 5/6/25.
//

import Foundation

final class FavoritesStateHolder: ObservableObject {
    @Published private(set) var favorites: [CharacterEntity] = []

    func toggleFavorite(_ character: CharacterEntity) {
        if favorites.contains(where: { $0.id == character.id }) {
            favorites.removeAll { $0.id == character.id }
        } else {
            favorites.append(character)
        }
    }
}
