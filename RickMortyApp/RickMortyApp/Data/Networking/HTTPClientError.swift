//
//  HTTPClientError.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

enum HTTPClientError: Error {
    case badURL
    case clientError
    case generic
    case parsingError
    case responseError
    case serverError
    case tooManyRequests
}
