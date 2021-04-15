//
//  HomepageInteractor.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import SwiftUI

protocol HomepageBusinessLogic {
    func loadCategoriesAndProducts()
    func filterProductsWith(selectedCategories: Set<Int>)
}

final class HomepageInteractor: HomepageBusinessLogic {
    private let presenter: HomepagePresentationLogic = HomepagePresenter()
    private let apiWorker: HomepageApiWorker = HomepageApiWorker(with: URLSession.shared)
    private let state: HomepageScene.State
	
	// MARK: - Init

    init(with state: HomepageScene.State) {
        self.state = state
    }

    // MARK: - Load categories and products

    func loadCategoriesAndProducts() {
        apiWorker.loadCategories { response in
            self.presenter.present(loadCategories: response, in: self.state)

            self.apiWorker.loadProducts { response in
                self.presenter.present(loadProducts: response, in: self.state)
            }
        }
    }

    // MARK: - Filter products

    func filterProductsWith(selectedCategories: Set<Int>) {
        let response = HomepageScene.FilterProduct.Reponse(rawData: selectedCategories)
        presenter.present(filterProducts: response, in: state)
    }
}
