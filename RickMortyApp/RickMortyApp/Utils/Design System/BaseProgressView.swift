//
//  BaseProgressView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 29/5/25.
//

import SwiftUI

struct BaseProgressView: View {
    var body: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.primary)
    }
}

#Preview {
    BaseProgressView()
}
