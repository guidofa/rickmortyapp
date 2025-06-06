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
        ScrollView {
            VStack(spacing: .largePadding) {
                Text(viewModel.character.name)
                    .font(.title)

                CharacterProfilePic(imageURL: viewModel.character.imageURL)
                    .frame(width: .profilePicDiameterExtra, height: .profilePicDiameterExtra)

                VStack(spacing: .mediumPadding) {
                    Text(viewModel.character.gender.rawValue)
                        
                    Text(viewModel.character.status.rawValue)
                }
                .font(.subheadline)
            }
            .foregroundStyle(.primary)
        }
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
