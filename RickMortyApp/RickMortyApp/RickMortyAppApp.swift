//
//  RickMortyAppApp.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import SwiftUI

@main
struct RickMortyAppApp: App {
    private let memoryCacheLimitInMB = 50
    private let diskCacheLimitInMB = 500
    private var memoryCapacity: Int { memoryCacheLimitInMB * 1024 * 1024 }
    private var diskCapacity: Int { diskCacheLimitInMB * 1024 * 1024 }

    init() {
        // Increase memory and disk cache to efficiently store downloaded images.
        URLCache.shared = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: "urlCache"
        )
    }

    var body: some Scene {
        WindowGroup {
            CharactersListFactory.create()
        }
    }
}
