//
//  CharactersErrorUIMapper.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 29/5/25.
//

import Foundation

private extension String {
    static var genericErrorMessage: Self { "Something went wrong, please try again." }
    static var tooManyRequest: Self { "Too many requests. Please, wait and try again later." }
}

final class CharactersErrorUIMapper {
    func map(error: CharactersDomainError?) -> String {
        switch error {
        case .tooManyRequests:
            return .tooManyRequest

        default:
            return .genericErrorMessage
        }
    }
}
