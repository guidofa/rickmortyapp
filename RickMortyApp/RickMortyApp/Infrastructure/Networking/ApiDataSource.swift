//
//  ApiDataSource.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

private extension String {
    static var character: Self { "character" }
    static var empty: Self { "" }
}

final class ApiDataSource: ApiDatasourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchCharacters() async -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        return await fetchCharactersInitial()
    }
    
    private func fetchCharactersInitial() async -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        let endpoint = Endpoint(path: .character, queryParameters: [:], method: .get)
        let result = await httpClient.makeRequest(directUrl: nil, endpoint: endpoint)
        return handleResult(result)
    }

    private func fetchCharacters(directUrl: String) async -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        let endpoint = Endpoint(path: .empty, queryParameters: [:], method: .get)
        let result = await httpClient.makeRequest(directUrl: directUrl, endpoint: endpoint)
        return handleResult(result)
    }

    private func handleResult(_ result: Result<Data, HTTPClientErrorEnum>) -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        switch result {
        case .success(let data):
            guard let page = try? JSONDecoder().decode(CharacterPageDTO.self, from: data) else {
                return .failure(.parsingError)
            }

            return .success(page)

        case .failure(let error):
            return .failure(error)
        }
    }
}
