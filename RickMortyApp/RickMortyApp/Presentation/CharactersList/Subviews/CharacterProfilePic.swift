//
//  CharacterProfilePic.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 30/5/25.
//

import Kingfisher
import SwiftUI

private extension CGFloat {
    static var overlayLineWidth: Self { 1 }
    static var profilePicDiameter: Self { 60 }
}

struct CharacterProfilePic: View {
    let imageURL: URL?

    var body: some View {
        KFImage(imageURL)
            .placeholder { BaseProgressView() }
            .cancelOnDisappear(true)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: .profilePicDiameter, height: .profilePicDiameter)
            .clipShape(Circle())
            .overlay(Circle().stroke(.primary, lineWidth: .overlayLineWidth))
            .shadow(radius: .smallPadding)
    }
}

#Preview {
    CharacterProfilePic(imageURL: nil)
}
