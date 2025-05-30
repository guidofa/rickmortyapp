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
            CharacterProfilePic(
                imageURL: character.imageURL
            )
            
            CharacterInfoView(
                name: character.name,
                gender: character.gender,
                status: character.status
            )
        }
    }
}

private struct CharacterInfoView: View {
    let name: String
    let gender: CharacterGenderEnum
    let status: CharacterStatusEnum

    var body: some View {
        VStack(alignment: .leading, spacing: .smallPadding) {
            Text(name)
                .font(.headline)

            HStack(spacing: .mediumPadding) {
                Circle()
                    .fill(getStatusColor(status: status))
                    .frame(width: .mediumPadding, height: .mediumPadding)
                
                Text(status.rawValue.capitalized)

                Text(getGenderIcon(gender: gender))
                    .foregroundColor(.primary)
                    .font(.subheadline)
            }
            .font(.caption)
        }
        .foregroundStyle(.primary)
    }

    private func getStatusColor(status: CharacterStatusEnum) -> Color {
        switch status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .gray
        }
    }

    private func getGenderIcon(gender: CharacterGenderEnum) -> String {
        switch gender {
        case .female: return "♀︎"
        case .genderless: return "⚲"
        case .male: return "♂︎"
        case .unknown: return "?"
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
                gender: .male,
                imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
                name: "Rick Sanchez",
                status: .alive
            )
        )
    )
}
