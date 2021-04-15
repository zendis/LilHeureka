//
//  NetworkError.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

enum NetworkError: LocalizedError {
    case general

    var errorDescription: String? {
        switch self {
        case .general:
            return "Ale ne, něco se pokazilo, opakujte prosím později"
        }
    }
}
