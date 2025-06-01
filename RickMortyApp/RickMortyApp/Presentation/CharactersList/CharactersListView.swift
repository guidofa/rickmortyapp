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
    static var searchPlaceholder: Self { "Search Characters" }
}

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersListViewModel

    @State private var searchText: String = ""

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
                            SearchView(
                                searchText: $searchText,
                                placeholder: .searchPlaceholder
                            ) {
                                Task { [weak viewModel] in
                                    await viewModel?.trigger(.searchCharacter(searchText))
                                }
                            }

                            if viewModel.charactersListToShow.isEmpty {
                                Text(.emptyStateMessage)
                                    .foregroundStyle(.primary)
                                    .font(.headline)
                            }  else {
                                ForEach(viewModel.charactersListToShow) { character in
                                    CharacterView(character: character)
                                }

                                if !viewModel.isLastPage {
                                    CharactersLoadMoreView {
                                        Task { [weak viewModel] in
                                            await viewModel?.trigger(.fetchCharacters)
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollDismissesKeyboard(.immediately)
                        
                        if viewModel.state == .loading {
                            Color.black.opacity(.opacity)
                                .ignoresSafeArea()

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
