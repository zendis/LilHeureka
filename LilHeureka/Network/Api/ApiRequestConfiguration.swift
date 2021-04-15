//
//  ApiRequestConfiguration.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

struct ApiRequestConfiguration {
    var httpMethod: HttpMethod = .get
    var host: String
    var httpEndpointPath: String
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
