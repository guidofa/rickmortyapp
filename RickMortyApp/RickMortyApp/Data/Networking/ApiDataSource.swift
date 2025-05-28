//
//  ApiDataSource.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class ApiDataSource: ApiDatasourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchCharacters(nextPageUrl: String?) async -> Result<CharacterPageDTO, HTTPClientError> {
        let baseUrl: String
        let endpoint: Endpoint

        if let nextPage = nextPageUrl {
            baseUrl = nextPage
            endpoint = Endpoint(path: "", queryParameters: [:], method: .get)
        } else {
            baseUrl = "https://rickandmortyapi.com/api/"
            endpoint = Endpoint(path: "character", queryParameters: [:], method: .get)
        }
        
        let result = await httpClient.makeRequest(baseUrl: baseUrl, endpoint: endpoint)

        guard case .success(let data) = result else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }
        
        guard let charactersList = try? JSONDecoder().decode(CharacterPageDTO.self, from: data) else {
            return .failure(.parsingError)
        }

        return .success(charactersList)
    }

}
