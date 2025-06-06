//
//  CharacterInfoView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 30/5/25.
//

import SwiftUI

private extension String {
    static var genderIconFemale: Self { "♀︎" }
    static var genderIconMale: Self { "♂︎" }
    static var genderlessIcon: Self { "⚲" }
    static var genderUnknownIcon: Self { "?" }
    static var heart: Self { "heart" }
    static var heartFill: Self { "heart.fill" }
}

struct CharacterInfoView: View {
    let name: String
    let gender: CharacterGenderEnum
    let isFavorite: Bool
    let status: CharacterStatusEnum

    let action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .smallPadding) {
                Text(name)
                    .font(.headline)

                HStack(spacing: .mediumPadding) {
                    HStack(spacing: .smallPadding) {
                        Circle()
                            .fill(getStatusColor(status: status))
                            .frame(width: .mediumPadding, height: .mediumPadding)
                        
                        Text(status.rawValue.capitalized)
                    }

                    Text(getGenderIcon(gender: gender))
                }
                .font(.subheadline)
            }
            .foregroundStyle(.primary)
            .padding(.horizontal, .smallPadding)

            Spacer(minLength: .mediumPadding)

            Button {
                action()
            } label: {
                Image(systemName: isFavorite ? .heartFill : .heart)
            }
            .buttonStyle(.borderless)
            .padding(.extraLargePadding)
        }
    }

    private func getGenderIcon(gender: CharacterGenderEnum) -> String {
        switch gender {
        case .female: return .genderIconFemale
        case .genderless: return .genderlessIcon
        case .male: return .genderIconMale
        case .unknown: return .genderUnknownIcon
        }
    }

    private func getStatusColor(status: CharacterStatusEnum) -> Color {
        switch status {
        case .alive, .all: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}

#Preview {
    CharacterInfoView(
        name: "Rick",
        gender: .male,
        isFavorite: true,
        status: .alive,
        action: {}
    )
}
