//
//  ProductDetailInteractor.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import SwiftUI

protocol ProductDetailBusinessLogic {
    func loadOffersFor(productId: Int)
    func prepareActionSheet(for offer: Offer)
    func hideActionSheet(value: Bool)
    func closeAlert(value: ProductDetailScene.AlertItem?)
}

final class ProductDetailInteractor: ProductDetailBusinessLogic {
    private let presenter: ProductDetailPresentationLogic = ProductDetailPresenter()
    private let apiWorker: ProductDetailApiWorker = ProductDetailApiWorker()
    private let state: ProductDetailScene.State
	
	// MARK: - Init

    init(with state: ProductDetailScene.State) {
        self.state = state
    }

    // MARK: - Load offers
	
    func loadOffersFor(productId: Int) {
        apiWorker.loadOffersFor(productId: productId) { response in
            self.presenter.present(loadOffers: response, in: self.state)
        }
    }

    // MARK: - Action sheet

    func prepareActionSheet(for offer: Offer) {
        let response = ProductDetailScene.PrepareActionSheet.Response(rawData: offer)
        presenter.present(prepareActionSheet: response, in: state)
    }

    func hideActionSheet(value: Bool) {
        let response = ProductDetailScene.HideActionSheet.Response(rawData: value)
        presenter.present(closeActionSheet: response, in: state)
    }

    // MARK: - Alert

    func closeAlert(value: ProductDetailScene.AlertItem?) {
        let response = ProductDetailScene.CloseAlert.Response(rawData: value)
        presenter.present(closeAlert: response, in: state)
    }
}
