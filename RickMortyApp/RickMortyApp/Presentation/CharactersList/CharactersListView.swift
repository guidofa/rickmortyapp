//
//  CharactersListView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersListViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                if viewModel.state == .blockingError {
                    CharactersListBlockingErrorView {
                        Task { [weak viewModel] in
                            await viewModel?.trigger(.fetchCharacters)
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.charactersListToShow) { character in
                            CharacterView(character: character)
                        }
                    }
                }
            }
            .navigationTitle("Rick and Morty")
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
