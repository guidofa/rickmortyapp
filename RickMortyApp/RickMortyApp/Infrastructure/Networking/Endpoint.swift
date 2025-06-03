//
//  Endpoint.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

struct Endpoint {
    let method: HTTPMethodEnum
    let path: String
    let queryParameters: [String: Any]
}
