//
//  CharactersListView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject private var viewModel: CharactersListViewModel

    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: .zero) {
            if viewModel.state == .loading {
                ProgressView()
                    .controlSize(.large)
                    .tint(.primary)
            } else if viewModel.state == .error {
                Text("Error")
                    .foregroundColor(.red)
                    .font(.headline)
            } else {
                List {
                    ForEach(viewModel.charactersListToShow, id: \.id) { character in
                        Text(character.name)
                    }
                }
            }
        }
        .task { [weak viewModel] in
            await viewModel?.trigger(.fetchCharacters)
        }
    }
}

#Preview {
    CharactersListView(
        viewModel: CharactersListViewModel(
            charactersErrorUIMapper: .init(),
            fetchCharactersUseCase: FetchCharactersUseCase(
                repository: CharactersRepository(
                    apiDatasource: ApiDataSource(
                        httpClient: URLSessionHTTPClient(
                            errorResolver: .init(),
                            requestMaker: .init()
                        )
                    ),
                    charactersDomainErrorMapper: .init(),
                    charactersDomainMapper: .init()
                )
            )
        )
    )
}
