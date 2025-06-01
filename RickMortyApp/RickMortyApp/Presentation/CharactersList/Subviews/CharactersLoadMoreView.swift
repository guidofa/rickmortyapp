//
//  CharactersLoadMoreView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 1/6/25.
//

import SwiftUI

private extension LocalizedStringKey {
    static var loadMore: Self { "Load more" }
}

struct CharactersLoadMoreView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(.loadMore)
                .foregroundStyle(.primary)
                .padding(.largePadding)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    CharactersLoadMoreView(
        action: {}
    )
}
