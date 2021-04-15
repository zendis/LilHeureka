//
//  OfferEndpoint.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 14.04.2021.
//

import Foundation

enum OfferEndpoint: ApiEndpoint {
    case list(productId: Int)

    func requestConfiguration() -> ApiRequestConfiguration {
        switch self {
        case .list(let productId):
            return ApiRequestConfiguration(host: host, httpEndpointPath: "/offers/\(productId)")
        }
    }
}
