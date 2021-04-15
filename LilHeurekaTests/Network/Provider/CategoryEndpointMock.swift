//
//  CategoryEndpointMock.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation
@testable import LilHeureka

enum CategoryEndpointMock: ApiEndpoint {
    case list

    func requestConfiguration() -> ApiRequestConfiguration {
        switch self {
        case .list:
            return ApiRequestConfiguration(host: NetworkConstantsMock.host, httpEndpointPath: "/categories")
        }
    }
}
