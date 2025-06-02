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
                        performFetchCharacters()
                    }
                } else {
                    ZStack {
                        List {
                            if viewModel.charactersListToShow.isEmpty {
                                Text(.emptyStateMessage)
                                    .foregroundStyle(.primary)
                                    .font(.headline)
                            }  else {
                                ForEach(viewModel.charactersListToShow) { character in
                                    CharacterView(character: character)
                                }

                                if !viewModel.isLastPage && searchText.isEmpty {
                                    CharactersLoadMoreView {
                                        performFetchCharacters()
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollDismissesKeyboard(.immediately)
                        .searchable(text: $searchText, prompt: .searchPlaceholder)
                        .onSubmit(of: .search) { performSearch() }
                        .onChange(of: searchText) { _, newValue in
                            if newValue.isEmpty {
                                performSearch()
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
            .navigationTitle(.appTitle)
        }
        .onAppear {
            performFetchCharacters()
        }
    }

    private func performFetchCharacters() {
        Task { [weak viewModel] in
            await viewModel?.trigger(.fetchCharacters)
        }
    }

    private func performSearch() {
        Task { [weak viewModel] in
            await viewModel?.trigger(.searchCharacter(searchText))
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
