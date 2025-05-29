//
//  Foundations+Extensions.swift
//  RickMortyApp
//
//  Created by Guido Fabio on 29/5/25.
//

import Foundation

extension Result {
    var failureValue: Error? {
        switch self {
            case .failure(let error):
                return error
            case .success:
                return nil
        }
    }
}
