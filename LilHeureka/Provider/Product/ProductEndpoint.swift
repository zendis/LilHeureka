//
//  ProductEndpoint.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 12.04.2021.
//

import Foundation

enum ProductEndpoint: ApiEndpoint {
    case list

    func requestConfiguration() -> ApiRequestConfiguration {
        switch self {
        case .list:
            return ApiRequestConfiguration(host: host, httpEndpointPath: "/products")
        }
    }
}
