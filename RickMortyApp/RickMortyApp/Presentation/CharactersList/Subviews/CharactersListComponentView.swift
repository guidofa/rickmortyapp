//
//  CharactersListComponentView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 9/6/25.
//

import SwiftUI

private extension LocalizedStringKey {
    static var emptyStateMessage: Self { "There are no characters to show" }
    static var searchPlaceholder: Self { "Search Characters" }
}

struct CharactersListComponentView: View {
    @EnvironmentObject var favoritesStateHolder: FavoritesStateHolder
    @EnvironmentObject var viewModel: CharactersListViewModel

    @Binding var searchText: String
    @Binding var selectedFilter: CharacterStatusEnum

    let characterDetailFactory: CharacterDetailFactoryType    

    var body: some View {
        List {
            CharactersFilterView(
                searchText: $searchText,
                selectedFilter: $selectedFilter
            )
            .environmentObject(viewModel)
            
            if viewModel.charactersListToShow.isEmpty {
                Text(.emptyStateMessage)
                    .font(.headline)
                    .foregroundStyle(.primary)
            } else {
                ForEach(viewModel.charactersListToShow) { character in
                    NavigationLink {
                        characterDetailFactory.create(character: character)
                    } label: {
                        CharacterView(
                            character: character,
                            isFavorite: favoritesStateHolder.isFavorite(id: character.id)
                        ) {
                            favoritesStateHolder.toggleFavorite(character)
                        }
                    }
                }
                
                if !viewModel.isLastPage && searchText.isEmpty {
                    CharactersLoadMoreView {
                        Task { [weak viewModel] in
                            await viewModel?.trigger(.fetchCharacters(selectedFilter))
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollDismissesKeyboard(.immediately)
        .searchable(text: $searchText, prompt: .searchPlaceholder)
        .onSubmit(of: .search) { performSearch() }
        .onChange(of: searchText) { _, newValue in
            if newValue.isEmpty {
                performSearch()
            }
        }
    }

    private func performSearch() {
        Task { [weak viewModel] in
            await viewModel?.trigger(.searchCharacter(searchText))
        }
    }
}

#Preview {
    CharactersListComponentView(
        searchText: .constant(""),
        selectedFilter: .constant(.all),
        characterDetailFactory: CharacterDetailFactory()
    )
}
