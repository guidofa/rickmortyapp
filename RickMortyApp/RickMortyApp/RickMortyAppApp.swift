//
//  RickMortyAppApp.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import SwiftUI

@main
struct RickMortyAppApp: App {
    private let favoritesStateHolder = FavoritesStateHolder()

    var body: some Scene {
        WindowGroup {
            TabContentView(
                characterListView: CharactersListFactory.create(),
                favoritesCharactersView: FavoritesCharactersView()
            )
            .environmentObject(favoritesStateHolder)
        }
    }
}
