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

extension CGFloat {
    static var smallPadding: Self { 4 }
    static var mediumPadding: Self { 8 }
    static var defaultPadding: Self { 12 }
    static var largePadding: Self { 16 }
    static var extraLargePadding: Self { 32 }
}
