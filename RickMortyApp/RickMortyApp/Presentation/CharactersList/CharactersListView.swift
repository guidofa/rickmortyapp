//
//  CharactersListView.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import SwiftUI

private extension Double {
    static var opacity: Self { 0.3 }
}

private extension LocalizedStringKey {
    static var appTitle: Self { "Rick and Morty" }
    static var emptyStateMessage: Self { "There are no characters to show" }
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
                    if viewModel.charactersListToShow.isEmpty {
                        Text(.emptyStateMessage)
                            .foregroundStyle(.primary)
                            .font(.headline)
                    } else {
                        ZStack {
                            List {
                                ForEach(viewModel.charactersListToShow) { character in
                                    CharacterView(character: character)
                                }

                                CharactersLoadMoreView {
                                    Task { [weak viewModel] in
                                        await viewModel?.trigger(.fetchCharacters)
                                    }
                                }
                            }
                            
                            if viewModel.state == .loading {
                                Color.black.opacity(.opacity)
                                    .ignoresSafeArea()

                                BaseProgressView()
                            }
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
                charactersDomainErrorMapper: .init(),
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
