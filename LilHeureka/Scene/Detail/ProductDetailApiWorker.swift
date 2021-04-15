//
//  ProductDetailApiWorker.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import Foundation

struct ProductDetailApiWorker {
    private let provider: OfferProvider = OfferProvider(with: URLSession.shared)

    // MARK : - Load offers

    func loadOffersFor(productId: Int, completion: @escaping (ProductDetailScene.LoadOffer.Response) -> Void) {
        provider.loadOffers(productId: productId) { (offers, error) in
            DispatchQueue.main.async {
                let response = ProductDetailScene.LoadOffer.Response(rawData: offers, error: error)
                completion(response)
            }
        }
    }
}
