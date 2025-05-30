//
//  CharacterView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 29/5/25.
//

import SwiftUI

struct CharacterView: View {
    let character: CharacterUIModel

    var body: some View {
        HStack(spacing: .mediumPadding) {
            CharacterProfilePic(imageURL: character.imageURL)

            VStack(alignment: .leading, spacing: .smallPadding) {
                Text(character.name)
                    .font(.headline)

                HStack(spacing: .smallPadding) {
                    Text(character.status.rawValue)

                    Text(character.gender)
                }
                .font(.subheadline)
            }
            .foregroundStyle(.primary)
        }
    }
}

private struct CharacterProfilePic: View {
    let imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if phase.error != nil {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            } else {
                BaseProgressView()
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(Circle())
        .overlay(Circle().stroke(.primary, lineWidth: 1))
        .shadow(radius: .smallPadding)
    }
}

#Preview {
    CharacterView(
        character: .init(
            domainModel: .init(
                id: 0,
                gender: "male",
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
                name: "Rick Sanchez",
                status: .alive
            )
        )
    )
}
