//
//  CharactersListBlockingErrorView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 30/5/25.
//

import SwiftUI

private extension LocalizedStringKey {
    static var retry: Self { "Try again" }
}

private extension String {
    static var logo: Self { "logo" }
}

struct CharactersListBlockingErrorView: View {
    let errorMessage: String
    let buttonAction: () -> Void

    var body: some View {
        VStack(spacing: .extraLargePadding) {
            Image(.logo)

            Text(errorMessage)
                .font(.headline)
                .padding(.horizontal, .mediumPadding)

            Spacer(minLength: .mediumPadding)

            Button(action: buttonAction) {
                Text(.retry)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.largePadding)
                    .background(Color.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: .cornerRadius)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
            }
        }
        .padding(.largePadding)
    }
}

#Preview {
    CharactersListBlockingErrorView(
        errorMessage: .logo,
        buttonAction: {}
    )
}
