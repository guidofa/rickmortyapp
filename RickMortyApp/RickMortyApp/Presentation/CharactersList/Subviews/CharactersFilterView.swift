//
//  CharactersFilterView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 9/6/25.
//

import SwiftUI

struct CharactersFilterView: View {
    @EnvironmentObject var viewModel: CharactersListViewModel
 
    @Binding var searchText: String
    @Binding var selectedFilter: CharacterStatusEnum

    var body: some View {
        Picker("", selection: $selectedFilter) {
            Text(CharacterStatusEnum.all.rawValue)
                .tag(CharacterStatusEnum.all)

            Text(CharacterStatusEnum.alive.rawValue)
                .tag(CharacterStatusEnum.alive)

            Text(CharacterStatusEnum.dead.rawValue)
                .tag(CharacterStatusEnum.dead)

            Text(CharacterStatusEnum.unknown.rawValue)
                .tag(CharacterStatusEnum.unknown)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedFilter) { _, newValue in
            searchText = ""
            viewModel.reset()
            Task { [weak viewModel] in
                await viewModel?.trigger(.fetchCharacters(newValue))
            }
        }
    }
}

#Preview {
    CharactersFilterView(
        searchText: .constant(""),
        selectedFilter: .constant(.alive)
    )
}
