//
//  Provider.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 12.04.2021.
//

import Foundation

class Provider {
    internal let networkConnect: NetworkConnectable
    internal let parser: ResponseParserable

    // MARK: - Init

    init(with session: URLSession, parser: ResponseParserable = JsonResponseParser()) {
        self.networkConnect = NetworkConnect(with: session)
        self.parser = parser
    }
}
