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
    @EnvironmentObject var favoritesStateHolder: FavoritesStateHolder

    @ObservedObject var viewModel: CharactersListViewModel

    @State private var searchText: String = ""
    @State private var selectedFilter: CharacterStatusEnum = .all

    let characterDetailFactory: CharacterDetailFactoryType

    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                if let errorMessage = viewModel.errorMessage {
                    CharactersListBlockingErrorView(errorMessage: errorMessage) {
                        Task { [weak viewModel] in
                            await viewModel?.trigger(.fetchCharacters(.all))
                        }
                    }
                } else {
                    ZStack {
                        CharactersListComponentView(
                            searchText: $searchText,
                            selectedFilter: $selectedFilter,
                            characterDetailFactory: characterDetailFactory
                        )
                        .environmentObject(viewModel)
                        
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
            guard let viewModel, viewModel.charactersListToShow.isEmpty else { return }
            await viewModel.trigger(.fetchCharacters(.all))
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
                    charactersDomainMapper: .init(),
                    inMemoryCache: InMemoryCache.shared
                )
            )
        ),
        characterDetailFactory: CharacterDetailFactory()
    )
}
