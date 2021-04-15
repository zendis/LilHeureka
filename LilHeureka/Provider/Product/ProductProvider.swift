//
//  ProductProvider.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 12.04.2021.
//

import Foundation

final class ProductProvider: Provider {

    // MARK: - List

    func loadProducts(completion: @escaping ([Product]?, NetworkError?) -> Void) {
        let configuration: ApiRequestConfiguration = ProductEndpoint.list.requestConfiguration()
        let request: URLRequest = URLRequest(with: configuration)

        networkConnect.loadApiEndpoint(with: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return completion(nil, NetworkError.general) }

                let products: [Product]? = self.parser.parse(data: data, into: [Product].self)
                completion(products, nil)
            case .failure:
                completion(nil, NetworkError.general)
            }
        }
    }
}
