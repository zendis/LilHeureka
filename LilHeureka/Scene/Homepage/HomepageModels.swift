//
//  HomepageModels.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import SwiftUI

enum HomepageScene {

    // MARK: - Category

    enum LoadCategory {
        struct Response {
            let rawData: [Category]?
            let error: NetworkError?
        }
    }

    // MARK: - Product

    enum LoadProduct {
        struct Response {
            let rawData: [Product]?
            let error: NetworkError?
        }
    }

    enum FilterProduct {
        struct Reponse {
            let rawData: Set<Int>
        }
    }
}

// MARK: - State

extension HomepageScene {
    final class State: ObservableObject {
        var loadedProducts: [Product] = []
        var loadedCategories: [Category] = []

        @Published var displayedProducts: [Product] = []
        @Published var selectedCategories: Set<Int> = Set()
        @Published var displayedCategories: [FilterRowView.Item] = []
        @Published var isLoadingData: Bool = true
    }
}
