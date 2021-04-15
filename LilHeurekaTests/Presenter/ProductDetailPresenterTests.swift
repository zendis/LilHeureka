//
//  ProductDetailPresenterTests.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 15.04.2021.
//

import XCTest
@testable import LilHeureka

final class ProductDetailPresenterTests: XCTestCase {
    let sut: ProductDetailPresentationLogic = ProductDetailPresenter()

    // MARK: - Offer tests

    func testPresentLoadedOffersSuccess() throws {
        let state = ProductDetailScene.State(product: Product(productId: 1, title: "Test Product 1", categoryId: 1))
        let response = ProductDetailScene.LoadOffer.Response(
            rawData: [Offer(offerId: 1, productId: 1, title: "Test Offer 1", description: nil, url: "", imgUrl: nil, price: 0.0)],
            error: nil
        )

        sut.present(loadOffers: response, in: state)
        XCTAssertFalse(state.isLoadingData)
        XCTAssert(state.offers.count == 1)
    }

    func testPresentLoadedOffersFailure() throws {
        let state = ProductDetailScene.State(product: Product(productId: 1, title: "Test Product 1", categoryId: 1))
        let response = ProductDetailScene.LoadOffer.Response(
            rawData: nil,
            error: NetworkError.general
        )

        sut.present(loadOffers: response, in: state)
        XCTAssertFalse(state.isLoadingData)
        XCTAssert(state.offers.count == 0)
    }

    // MARK: - Action sheet tests

    func testPresentPrepareActionSheet() throws {
        let state = ProductDetailScene.State(product: Product(productId: 1, title: "Test Product 1", categoryId: 1))

        let offers: [Offer] = [
            Offer(offerId: 1, productId: 1, title: "Test Offer 1", description: nil, url: "", imgUrl: nil, price: 0.0),
            Offer(offerId: 2, productId: 1, title: "Test Offer 2", description: "Description 2", url: "", imgUrl: nil, price: 0.0),
            Offer(offerId: 3, productId: 1, title: "Test Offer 3", description: nil, url: "http://google.com", imgUrl: nil, price: 0.0),
            Offer(offerId: 4, productId: 1, title: "Test Offer 4", description: "Description 4", url: "http://google.com", imgUrl: nil, price: 0.0)
        ]

        // No action sheet (no description, no url)
        sut.present(prepareActionSheet: actionSheetResponse(with: offers[0]), in: state)
        XCTAssertNil(state.selectedOffer)
        XCTAssertTrue(state.actionSheetButtons.isEmpty)
        XCTAssertFalse(state.showActionSheet)

        // Action sheet with description
        sut.present(prepareActionSheet: actionSheetResponse(with: offers[1]), in: state)
        XCTAssertNotNil(state.selectedOffer)
        XCTAssert(state.selectedOffer?.offerId == 2)
        XCTAssert(state.actionSheetButtons.count == 2)
        XCTAssertTrue(state.showActionSheet)

        // Action sheet with url
        sut.present(prepareActionSheet: actionSheetResponse(with: offers[2]), in: state)
        XCTAssertNotNil(state.selectedOffer)
        XCTAssert(state.selectedOffer?.offerId == 3)
        XCTAssert(state.actionSheetButtons.count == 2)
        XCTAssertTrue(state.showActionSheet)

        // Action sheet with all actions
        sut.present(prepareActionSheet: actionSheetResponse(with: offers[3]), in: state)
        XCTAssertNotNil(state.selectedOffer)
        XCTAssert(state.selectedOffer?.offerId == 4)
        XCTAssert(state.actionSheetButtons.count == 3)
        XCTAssertTrue(state.showActionSheet)
    }

    private func actionSheetResponse(with offer: Offer) -> ProductDetailScene.PrepareActionSheet.Response {
        return ProductDetailScene.PrepareActionSheet.Response(rawData: offer)
    }
}
