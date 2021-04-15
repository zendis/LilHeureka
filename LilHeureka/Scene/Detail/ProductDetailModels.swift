//
//  ProductDetailModels.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import SwiftUI

enum ProductDetailScene {

    // MARK: - Offer

    enum LoadOffer {
        struct Response {
            let rawData: [Offer]?
            let error: NetworkError?
        }
    }

    // MARK: - Action sheet

    enum PrepareActionSheet {
        struct Response {
            let rawData: Offer
        }
    }

    enum HideActionSheet {
        struct Response {
            let rawData: Bool
        }
    }

    // MARK: - Alert

    enum CloseAlert {
        struct Response {
            let rawData: ProductDetailScene.AlertItem?
        }
    }
}

// MARK: - State

extension ProductDetailScene {
    final class State: ObservableObject {
        var product: Product
        var actionSheetButtons: [ActionSheet.Button] = []

        @Published var offers: [Offer] = []
        @Published var mainImageUrl: String?
        @Published var isLoadingData: Bool = true
        @Published var showActionSheet: Bool = false
        @Published var selectedOffer: Offer?
        @Published var alertItem: ProductDetailScene.AlertItem?

        // MARK: - Init

        init(product: Product) {
            self.product = product
        }
    }
}

// MARK: - Data

extension ProductDetailScene {
    struct AlertItem: Identifiable {
        let id: Int
        let description: String
    }
}
