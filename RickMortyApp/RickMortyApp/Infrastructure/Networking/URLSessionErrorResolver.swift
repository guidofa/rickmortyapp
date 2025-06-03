//
//  Untitled.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class URLSessionErrorResolver {
    func resolve(statusCode: Int) -> HTTPClientErrorEnum {
        switch statusCode {
        case 429:
            return .tooManyRequests

        case 400..<500:
            return .clientError

        case 500..<600:
            return .serverError

        default:
            return .generic
        }
    }
}
