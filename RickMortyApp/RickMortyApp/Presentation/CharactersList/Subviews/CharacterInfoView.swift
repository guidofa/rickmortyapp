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
}

struct CharacterInfoView: View {
    let name: String
    let gender: CharacterGenderEnum
    let status: CharacterStatusEnum

    var body: some View {
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
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}

#Preview {
    CharacterInfoView(
        name: "Rick",
        gender: .male,
        status: .alive
    )
}
