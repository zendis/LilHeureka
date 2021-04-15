//
//  ProductDetailPresenter.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import SwiftUI

protocol ProductDetailPresentationLogic {
    func present(loadOffers response: ProductDetailScene.LoadOffer.Response, in state: ProductDetailScene.State)
    func present(prepareActionSheet response: ProductDetailScene.PrepareActionSheet.Response, in state: ProductDetailScene.State)
    func present(closeActionSheet response: ProductDetailScene.HideActionSheet.Response, in state: ProductDetailScene.State)
    func present(closeAlert response: ProductDetailScene.CloseAlert.Response, in state: ProductDetailScene.State)
}

final class ProductDetailPresenter: ProductDetailPresentationLogic {
    @Environment(\.openURL) var openURL
    
    // MARK: - Present offers
    
    func present(loadOffers response: ProductDetailScene.LoadOffer.Response, in state: ProductDetailScene.State) {
        state.isLoadingData = false

        guard let offers = response.rawData else { return }
        state.mainImageUrl = offers.first(where: { $0.imgUrl != nil })?.imgUrl
        state.offers = offers
    }

    // MARK: - Action sheet

    func present(prepareActionSheet response: ProductDetailScene.PrepareActionSheet.Response, in state: ProductDetailScene.State) {
        guard (response.rawData.description != nil || URL(string: response.rawData.url) != nil) else { return }

        state.selectedOffer = response.rawData
        state.actionSheetButtons = createActionSheetButtons(for: response.rawData, state: state)
        state.showActionSheet = true
    }

    func present(closeActionSheet response: ProductDetailScene.HideActionSheet.Response, in state: ProductDetailScene.State) {
        state.showActionSheet = response.rawData
    }

    private func createActionSheetButtons(for offer: Offer, state: ProductDetailScene.State) -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []

        if let description = offer.description {
            buttons.append(
                .default(
                    Text("Zobrazit popisek"),
                    action: {
                        state.alertItem = ProductDetailScene.AlertItem(id: offer.offerId, description: description)
                    }
                )
            )
        }

        if let url = URL(string: offer.url) {
            buttons.append(
                .default(
                    Text("Navštívit odkaz"),
                    action: {
                        self.openURL(url)
                    }
                )
            )
        }

        buttons.append(.cancel())
        return buttons
    }

    // MARK: - Alert

    func present(closeAlert response: ProductDetailScene.CloseAlert.Response, in state: ProductDetailScene.State) {
        state.alertItem = response.rawData
    }
}
