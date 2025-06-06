//
//  CharacterProfilePic.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 30/5/25.
//

import Kingfisher
import SwiftUI

struct CharacterProfilePic: View {
    let imageURL: URL?

    var body: some View {
        KFImage(imageURL)
            .placeholder { BaseProgressView() }
            .cancelOnDisappear(true)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .overlay(Circle().stroke(.primary, lineWidth: .overlayLineWidth))
            .shadow(radius: .smallPadding)
    }
}

#Preview {
    CharacterProfilePic(imageURL: nil)
}
