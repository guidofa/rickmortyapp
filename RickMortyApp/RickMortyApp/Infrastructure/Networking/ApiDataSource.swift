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
    static var status: Self { "status" }
}

final class ApiDataSource: ApiDatasourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchCharacters(filterStatus: CharacterStatusEnum, nextPage: String?) async -> Result<CharacterPageDTO, HTTPClientErrorEnum> {
        let result: Result<Data, HTTPClientErrorEnum>

        if let nextPage {
            result = await httpClient.makeRequest(directUrl: nextPage, endpoint: nil)
        } else {
            var queryParameters = [String: Any]()

            if filterStatus != .all {
                queryParameters[.status] = filterStatus
            }

            let endpoint = Endpoint(method: .get, path: .character, queryParameters: queryParameters)
            result = await httpClient.makeRequest(directUrl: nil, endpoint: endpoint)
        }

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
