//
//  FavoritesCharactersView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 5/6/25.
//

import SwiftUI

private extension LocalizedStringKey {
    static var emptyStateMessage: Self { "There are no favorites yet" }
    static var navTitle: Self { "Favorites" }
}

struct FavoritesCharactersView: View {
    @EnvironmentObject var favoritesStateHolder: FavoritesStateHolder
    
    var body: some View {
        NavigationStack {
            Group {
                if favoritesStateHolder.favorites.isEmpty {
                    Text(.emptyStateMessage)
                        .font(.headline)
                        .foregroundStyle(.primary)
                } else {
                    List {
                        ForEach(favoritesStateHolder.favorites) { character in
                            CharacterView(character: character, isFavorite: favoritesStateHolder.isFavorite(id: character.id)) {
                                favoritesStateHolder.toggleFavorite(character)
                            }
                        }
                    }
                }
            }
            .navigationTitle(.navTitle)
        }
    }
}

#Preview {
    FavoritesCharactersView()
}
