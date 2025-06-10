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

                CharacterDetailInfoView(
                    gender: viewModel.character.gender.rawValue,
                    status: viewModel.character.status.rawValue
                )
            }
            .foregroundStyle(.primary)
        }
    }
}

private struct CharacterDetailInfoView: View {
    let gender: String
    let status: String
    
    var body: some View {
        VStack(spacing: .mediumPadding) {
            InfoView(
                title: "Gender: ",
                value: gender
            )

            InfoView(
                title: "Status: ",
                value: status
            )
        }
        .foregroundStyle(.primary)
    }
}

private struct InfoView: View {
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: .mediumPadding) {
            Text(title)
                .font(.headline)

            Text(value)
                .font(.subheadline)
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
