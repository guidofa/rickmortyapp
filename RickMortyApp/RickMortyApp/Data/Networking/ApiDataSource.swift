//
//  ApiDataSource.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

protocol ApiDatasourceType {
    func  fetchCharacters(nextPageUrl: String?) async -> Result<CharacterPageDTO, HTTPClientErrorEnum>
}

final class ApiDataSource: ApiDatasourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchCharacters(nextPageUrl: String?) async -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        guard let url = nextPageUrl else {
            return await fetchCharactersInitial()
        }

        return await fetchCharacters(directUrl: url)
    }
    
    private func fetchCharactersInitial() async -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        let endpoint = Endpoint(path: "character", queryParameters: [:], method: .get)
        let result = await httpClient.makeRequest(directUrl: nil, endpoint: endpoint)
        return handleResult(result)
    }

    private func fetchCharacters(directUrl: String) async -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        let endpoint = Endpoint(path: "", queryParameters: [:], method: .get)
        let result = await httpClient.makeRequest(directUrl: directUrl, endpoint: endpoint)
        return handleResult(result)
    }

    private func handleResult(_ result: Result<Data, HTTPClientErrorEnum>) -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        switch result {
        case .success(let data):
            if let page = try? JSONDecoder().decode(CharacterPageDTO.self, from: data) {
                return .success(page)
            } else {
                return .failure(.parsingError)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
