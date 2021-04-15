//
//  URLRequest+Extensions.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

extension URLRequest {

    // MARK: - Init with API configuration

    init(with configuration: ApiRequestConfiguration) {
        var endpointUrl = URL(string: configuration.host)!
        if !configuration.httpEndpointPath.isEmpty {
            endpointUrl.appendPathComponent(configuration.httpEndpointPath)
        }

        self.init(url: endpointUrl)
        self.httpMethod = configuration.httpMethod.rawValue
    }
}
