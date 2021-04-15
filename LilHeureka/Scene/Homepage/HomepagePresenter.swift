//
//  HomepagePresenter.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

protocol HomepagePresentationLogic {
    func present(loadCategories response: HomepageScene.LoadCategory.Response, in state: HomepageScene.State)
    func present(loadProducts response: HomepageScene.LoadProduct.Response, in state: HomepageScene.State)
    func present(filterProducts response: HomepageScene.FilterProduct.Reponse, in state: HomepageScene.State)
}

final class HomepagePresenter: HomepagePresentationLogic {
    private let categoryIcons: [Int: String] = [
        1: "IconTelephone",
        2: "IconPlant",
        3: "IconBell"
    ]

    // MARK: - Present categories

    func present(loadCategories response: HomepageScene.LoadCategory.Response, in state: HomepageScene.State) {
        state.loadedCategories = response.rawData ?? []
        
        var categories: [FilterRowView.Item] = response.rawData?.map({ FilterRowView.Item(id: $0.categoryId, title: $0.title, iconName: categoryIcons[$0.categoryId] ?? "IconBell", isDestructive: false) }) ?? []
        categories.insert(FilterRowView.Item(id: 0, title: "Vše", iconName: "IconAll", isDestructive: true), at: 0)

        state.displayedCategories = categories
    }
    
    // MARK: - Present products
    
    func present(loadProducts response: HomepageScene.LoadProduct.Response, in state: HomepageScene.State) {
        state.isLoadingData = false

        guard let products = response.rawData else { return }
        state.loadedProducts = products
        state.displayedProducts = products
    }

    // MARK: - Filter products

    func present(filterProducts response: HomepageScene.FilterProduct.Reponse, in state: HomepageScene.State) {
        state.selectedCategories = response.rawData

        guard !state.selectedCategories.isEmpty else {
            state.displayedProducts = state.loadedProducts
            return
        }
        state.displayedProducts = state.loadedProducts.filter({ state.selectedCategories.contains($0.categoryId) })
    }
}
