//
//  Offer.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 14.04.2021.
//

import Foundation

struct Offer: Hashable, Decodable {
    let offerId: Int
    let productId: Int
    let title: String
    let description: String?
    let url: String
    let imgUrl: String?
    let price: Double

    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "cs_CZ")

        return formatter.string(from: NSNumber(value: price)) ?? "0 Kč"
    }
}

extension Offer {
    enum CodingKeys: String, CodingKey {
        case offerId
        case productId
        case title
        case description
        case url
        case imgUrl = "img_url"
        case price
    }
}
