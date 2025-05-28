//
//  Untitled.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class URLSessionErrorResolver {
    func resolve(error: Error) -> HTTPClientError {
        return .generic
    }

    func resolve(statusCode: Int) -> HTTPClientError {
        guard statusCode != 429 else {
            return .tooManyRequests
        }
        guard statusCode < 500 else {
            return .clientError
        }

        return .serverError
    }
}
