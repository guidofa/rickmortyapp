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
                        favoritesStateHolder
                            .toggleFavorite(
                                .init(
                                    id: 0,
                                    gender: .male,
                                    imageURL: .init(string: ""),
                                    name: "Rick",
                                    status: .alive
                                )
                            )
                    }
                } else {
                    ZStack {
                        List {
                            Picker(.appTitle, selection: $selectedFilter) {
                                Text(CharacterStatusEnum.all.rawValue)
                                    .tag(CharacterStatusEnum.all)

                                Text(CharacterStatusEnum.alive.rawValue)
                                    .tag(CharacterStatusEnum.alive)

                                Text(CharacterStatusEnum.dead.rawValue)
                                    .tag(CharacterStatusEnum.dead)

                                Text(CharacterStatusEnum.unknown.rawValue)
                                    .tag(CharacterStatusEnum.unknown)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .onChange(of: selectedFilter) { _, newValue in
                                searchText = ""
                                viewModel.reset()
                                performFetchCharacters(filter: newValue)
                            }
                            
                            if viewModel.charactersListToShow.isEmpty {
                                Text(.emptyStateMessage)
                                    .foregroundStyle(.primary)
                                    .font(.headline)
                            } else {
                                ForEach(viewModel.charactersListToShow) { character in
                                    NavigationLink {
                                        characterDetailFactory.create(character: character)
                                    } label: {
                                        CharacterView(
                                            character: character
                                        )
                                    }
                                }
                                
                                if !viewModel.isLastPage && searchText.isEmpty {
                                    CharactersLoadMoreView {
                                        performFetchCharacters(filter: selectedFilter)
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
            performFetchCharacters(filter: .all)
        }
    }

    private func performFetchCharacters(filter: CharacterStatusEnum) {
        Task { [weak viewModel] in
            await viewModel?.trigger(.fetchCharacters(filter))
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
                    charactersDomainMapper: .init(),
                    inMemoryCache: InMemoryCache.shared
                )
            )
        ),
        characterDetailFactory: CharacterDetailFactory()
    )
}
