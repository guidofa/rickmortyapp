//
//  FavoritesCharactersView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 5/6/25.
//

import SwiftUI

struct FavoritesCharactersView: View {
    @EnvironmentObject var favoritesStateHolder: FavoritesStateHolder

    var body: some View {
        Text(favoritesStateHolder.favorites.first?.name ?? "No favs")
            .font(.title)
            .foregroundStyle(.blue)
    }
}

#Preview {
    FavoritesCharactersView()
}
