//
//  ContentView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 5/6/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var favoritesStateHolder: FavoritesStateHolder

    let characterListView: CharactersListView
    let favoritesCharactersView: FavoritesCharactersView
    
    var body: some View {
        TabView {
            characterListView.tabItem {
                Label("List", systemImage: "list.bullet.clipboard")
            }

            favoritesCharactersView.tabItem {
                Label("Favorite", systemImage: "star")
            }
        }
        .environmentObject(favoritesStateHolder)
    }
}
