//
//  URLSessionRequestMaker.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class URLSessionRequestMaker {
    func url(baseUrl: String, endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents(string: baseUrl + endpoint.path)
        let urlQueryParameters = endpoint.queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }

        urlComponents?.queryItems = urlQueryParameters
        
        return urlComponents?.url
    }
}
