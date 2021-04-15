//
//  ApiEndpoint.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

protocol ApiEndpoint {
    func requestConfiguration() -> ApiRequestConfiguration
}

extension ApiEndpoint {
    var host: String { "https://heureka-testday.herokuapp.com" }
}
