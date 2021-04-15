//
//  Struct.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import Foundation

enum CategoryEndpoint: ApiEndpoint {
    case list

    func requestConfiguration() -> ApiRequestConfiguration {
        switch self {
        case .list:
            return ApiRequestConfiguration(host: host, httpEndpointPath: "/categories")
        }
    }
}
