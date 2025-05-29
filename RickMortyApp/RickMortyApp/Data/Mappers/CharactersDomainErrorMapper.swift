//
//  CharactersDomainErrorMapper.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

final class CharactersDomainErrorMapper {
    func map(error: HTTPClientError?) -> CharactersDomainError {
        guard error == .tooManyRequests else {
            return .generic
        }

        return .tooManyRequests
    }
}
