//
//  HomepageApiWorker.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

struct HomepageApiWorker {
    private let productProvider: ProductProvider
    private let categoryProvider: CategoryProvider

    // MARK: - Init

    init(with session: URLSession) {
        productProvider = ProductProvider(with: session)
        categoryProvider = CategoryProvider(with: session)
    }

    // MARK : - Load categories

    func loadCategories(completion: @escaping (HomepageScene.LoadCategory.Response) -> Void) {
        categoryProvider.loadCategories { (categories, error) in
            DispatchQueue.main.async {
                let response = HomepageScene.LoadCategory.Response(rawData: categories, error: error)
                completion(response)
            }
        }
    }

    // MARK: - Load products

    func loadProducts(completion: @escaping (HomepageScene.LoadProduct.Response) -> Void) {
        productProvider.loadProducts { (products, error) in
            DispatchQueue.main.async {
                let response = HomepageScene.LoadProduct.Response(rawData: products, error: error)
                completion(response)
            }
        }
    }
}
