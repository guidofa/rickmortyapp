//
//  CharactersDomainErrorMapper.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class CharactersDomainErrorMapper {
    func map(error: HTTPClientErrorEnum?) -> CharactersDomainError {
        switch error {
        case .tooManyRequests:
            return .tooManyRequests

        default:
            return .generic
        }
    }
}
