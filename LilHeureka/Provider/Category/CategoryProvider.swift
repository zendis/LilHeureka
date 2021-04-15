//
//  CategoryProvider.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import Foundation

final class CategoryProvider: Provider {

    // MARK: - List

    func loadCategories(completion: @escaping ([Category]?, NetworkError?) -> Void) {
        let configuration: ApiRequestConfiguration = CategoryEndpoint.list.requestConfiguration()
        let request: URLRequest = URLRequest(with: configuration)

        networkConnect.loadApiEndpoint(with: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return completion(nil, NetworkError.general) }

                let categories: [Category]? = self.parser.parse(data: data, into: [Category].self)
                completion(categories, nil)
            case .failure:
                completion(nil, NetworkError.general)
            }
        }
    }
}
