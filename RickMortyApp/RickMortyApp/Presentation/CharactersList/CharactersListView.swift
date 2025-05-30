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
        Task { [weak viewModel] in
            await viewModel?.trigger(.fetchCharacters)
        }
    }

    var body: some View {
        VStack(spacing: .zero) {
            if viewModel.state == .blockingError {
                Text("Error")
                    .foregroundColor(.red)
                    .font(.headline)
            } else {
                List {
                    ForEach(viewModel.charactersListToShow) { character in
                        CharacterView(character: character)
                    }

                    switch viewModel.state {
                    case .loading:
                        BaseProgressView()
                    case .error:
                        Text("ERROR")

                    case .lastPage:
                        Text("Final de pagina")
                        
                    default:
                        Button {
                            Task { [weak viewModel] in
                                await viewModel?.trigger(.fetchCharacters)
                            }
                        } label: {
                            Text("Load more")
                        }
                    }
                    
                }
            }
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
