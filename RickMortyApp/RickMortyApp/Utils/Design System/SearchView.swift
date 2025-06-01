//
//  SearchView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 1/6/25.
//

import SwiftUI

private extension String {
    static var circleFill: Self { "xmark.circle.fill" }
    static var magnifyingglass: Self { "magnifyingglass" }
}

struct SearchView: View {
    @Binding var searchText: String

    var placeholder: LocalizedStringKey
    var onCommit: (() -> Void)? = nil

    var body: some View {
        HStack {
            Image(systemName: .magnifyingglass)
                .foregroundColor(.secondary)

            TextField(placeholder, text: $searchText, onCommit: {
                onCommit?()
            })
            .foregroundColor(.primary)
            .disableAutocorrection(true)
            .autocapitalization(.none)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    onCommit?()
                }) {
                    Image(systemName: .circleFill)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, .defaultPadding)
        .padding(.vertical, .mediumPadding)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadius)
                .fill(Color(.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: .cornerRadius)
                .stroke(Color(.systemGray4), lineWidth: .overlayLineWidth)
        )
    }
}

#Preview {
    SearchView(
        searchText: .constant(
            "Hola"
        ),
        placeholder: .init("Placeholder")
    )
}
