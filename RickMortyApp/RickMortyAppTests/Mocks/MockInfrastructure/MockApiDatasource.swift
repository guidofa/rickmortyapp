//
//  MockApiDatasource.swift
//  RickMortyAppTests
//
//  Created by Guido Fabio on 31/5/25.
//

import Foundation

@testable import RickMortyApp
import Foundation

final class MockApiDatasource: ApiDatasourceType {
    var fetchCharactersCalled = false

    func fetchCharacters() async -> Result<RickMortyApp.CharacterPageDTO, RickMortyApp.HTTPClientErrorEnum> {
        fetchCharactersCalled = true
        return .success(
            .init(
                results: [],
                info: .init(
                    next: nil,
                    prev: nil
                )
            )
        )
    }
}

final class MockApiDatasourceFailure: ApiDatasourceType {
    var fetchCharactersCalled = false

    func fetchCharacters() async -> Result<RickMortyApp.CharacterPageDTO, RickMortyApp.HTTPClientErrorEnum> {
        fetchCharactersCalled = true
        return .failure(.generic)
    }
}
