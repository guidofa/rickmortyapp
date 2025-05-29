//
//  CharactersErrorUIMapper.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 29/5/25.
//

import Foundation

final class CharactersErrorUIMapper {
    func map(error: CharactersDomainError?) -> String {
        guard let error else { return "Something went wrong" }
        
        switch error {
        case .tooManyRequests:
            return "Too many requests. Please try again later."

        default:
            return "Something went wrong"
        }
    }
}
