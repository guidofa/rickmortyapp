//
//  InMemoryCache.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 3/6/25.
//

protocol InMemoryCacheType {
    func getCharactersPage(page: String?) async -> PageCharactersEntity?
    func setCharactersPage(characters: PageCharactersEntity, page: String?) async
}

actor InMemoryCache: InMemoryCacheType {
    static let shared = InMemoryCache()

    private var cache: [String?: PageCharactersEntity] = [:]

    func getCharactersPage(page: String?) async -> PageCharactersEntity? {
        cache[page]
    }

    func setCharactersPage(characters: PageCharactersEntity, page: String?) async {
        cache[page] = characters
    }
}
