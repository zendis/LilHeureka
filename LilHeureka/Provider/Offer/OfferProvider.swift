//
//  OfferProvider.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 14.04.2021.
//

import Foundation

final class OfferProvider: Provider {

    // MARK: - List

    func loadOffers(productId: Int, completion: @escaping ([Offer]?, NetworkError?) -> Void) {
        let configuration: ApiRequestConfiguration = OfferEndpoint.list(productId: productId).requestConfiguration()
        let request: URLRequest = URLRequest(with: configuration)

        networkConnect.loadApiEndpoint(with: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return completion(nil, NetworkError.general) }

                let offers: [Offer]? = self.parser.parse(data: data, into: [Offer].self)
                completion(offers, nil)
            case .failure:
                completion(nil, NetworkError.general)
            }
        }
    }
}
