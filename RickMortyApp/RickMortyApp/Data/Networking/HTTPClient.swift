//
//  HTTPClient.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 28/5/25.
//

import Foundation

protocol HTTPClient {
    func makeRequest(directUrl: String?, endpoint: Endpoint) async -> Result<Data, HTTPClientError>
}
