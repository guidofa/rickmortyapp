//
//  CharacterView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 29/5/25.
//

import Kingfisher
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
