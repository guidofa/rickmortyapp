//
//  CharacterDetailView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 4/6/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel

    var body: some View {
        Text(verbatim: viewModel.character.name)
    }
}

#Preview {
    CharacterDetailView(
        viewModel: .init(
            character: .init(
                id: 0,
                gender: .unknown,
                imageURL: nil,
                name: "Rick",
                status: .alive
            )
        )
    )
}
