//
//  CharactersListView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import SwiftUI

private extension LocalizedStringKey {
    static var appTitle: Self { "Rick and Morty" }
}

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersListViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                if let errorMessage = viewModel.errorMessage {
                    CharactersListBlockingErrorView(errorMessage: errorMessage) {
                        Task { [weak viewModel] in
                            await viewModel?.trigger(.fetchCharacters)
                        }
                    }
                } else {
                    ZStack {
                        List {
                            ForEach(viewModel.charactersListToShow) { character in
                                CharacterView(character: character)
                            }
                        }

                        if viewModel.state == .blockingLoading {
                            BaseProgressView()
                        }
                    }
                }
            }
            .navigationTitle(.appTitle)
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
