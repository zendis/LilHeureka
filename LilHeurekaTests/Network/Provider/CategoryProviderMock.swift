//
//  CategoryProviderMock.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation
@testable import LilHeureka

struct CategoryProviderMock {
    private let networkConnect: NetworkConnectable
    private let parser: ResponseParserable

    // MARK: - Init

    init(networkConnect: NetworkConnectable, parser: ResponseParserable) {
        self.networkConnect = networkConnect
        self.parser = parser
    }

    // MARK: - Load categories

    func loadCategories(completion: @escaping ([CategoryMock]?) -> Void) {
        let request: URLRequest = URLRequest(with: CategoryEndpointMock.list.requestConfiguration())
        networkConnect.loadApiEndpoint(with: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return completion(nil) }
                completion(parser.parse(data: data, into: [CategoryMock].self))
            case .failure:
                completion(nil)
            }
        }
    }
}
