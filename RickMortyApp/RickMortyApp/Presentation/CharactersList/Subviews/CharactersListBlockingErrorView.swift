//
//  CharactersListBlockingErrorView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 30/5/25.
//

import SwiftUI

struct CharactersListBlockingErrorView: View {
    let buttonAction: () -> Void
    
    var body: some View {
        VStack(spacing: .mediumPadding) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.title)
            
            Text("Something went wrong")
                .font(.caption)
            
            Button("Retry", action: buttonAction)
        }
    }
}
