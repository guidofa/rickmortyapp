//
//  URLSessionHTTPClient.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    private let errorResolver: URLSessionErrorResolver
    private let requestMaker: URLSessionRequestMaker
    private let session: URLSession
     
    init(errorResolver: URLSessionErrorResolver, requestMaker: URLSessionRequestMaker, session: URLSession = .shared) {
        self.errorResolver = errorResolver
        self.requestMaker = requestMaker
        self.session = session
    }

    func makeRequest(baseUrl: String, endpoint: Endpoint) async -> Result<Data, HTTPClientError> {
        guard let url = requestMaker.url(baseUrl: baseUrl, endpoint: endpoint) else {
            return .failure(.badURL)
        }
        
        do {
            let result = try await session.data(from: url)

            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.responseError)
            }

            guard response.statusCode == 200 else {
                return .failure(errorResolver.resolve(statusCode: response.statusCode))
            }

            return .success(result.0)
        } catch {
            return .failure(errorResolver.resolve(error: error))
        }
    }
}
