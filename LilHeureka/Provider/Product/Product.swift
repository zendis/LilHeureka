//
//  Product.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 12.04.2021.
//

import Foundation

struct Product: Hashable, Decodable {
    let productId: Int
    let title: String
    let categoryId: Int
}
