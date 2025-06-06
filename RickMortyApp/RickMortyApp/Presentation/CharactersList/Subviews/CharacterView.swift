//
//  CharacterView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 29/5/25.
//

import Kingfisher
import SwiftUI

struct CharacterView: View {
    let character: CharacterEntity
    let isFavorite: Bool

    let action: () -> Void

    var body: some View {
        HStack(spacing: .mediumPadding) {
            CharacterProfilePic(
                imageURL: character.imageURL
            )
            .frame(width: .profilePicDiameter, height: .profilePicDiameter)
            
            CharacterInfoView(
                name: character.name,
                gender: character.gender,
                isFavorite: isFavorite,
                status: character.status,
                action: action
            )
        }
    }
}

#Preview {
    CharacterView(
        character: .init(
            id: 0,
            gender: .male,
            imageURL: nil,
            name: "Rick",
            status: .alive
        ),
        isFavorite: true,
        action: {}
    )
}
