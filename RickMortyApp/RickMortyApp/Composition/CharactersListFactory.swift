//
//  CharactersListFactory.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class CharactersListFactory {
    static func create() -> CharactersListView {
        return CharactersListView(
            viewModel: createViewModel()
        )
    }

    private static func createViewModel() -> CharactersListViewModel {
        return CharactersListViewModel(
            charactersErrorUIMapper: .init(),
            fetchCharactersUseCase: createUseCase()
        )
    }

    private static func createUseCase() -> FetchCharactersUseCase {
        return FetchCharactersUseCase(
            charactersDomainErrorMapper: .init(),
            repository: createRepository()
        )
    }

    private static func createRepository() -> CharactersRepositoryType {
        return CharactersRepository(
            apiDatasource: createDataSource(),
            charactersDomainErrorMapper: .init(),
            charactersDomainMapper: .init(),
            inMemoryCache: InMemoryCache.shared
        )
    }

    private static func createDataSource() -> ApiDatasourceType {
        let httpClient = URLSessionHTTPClient(
            errorResolver: .init(),
            requestMaker: .init()
        )

        return ApiDataSource(httpClient: httpClient)
    }
}
