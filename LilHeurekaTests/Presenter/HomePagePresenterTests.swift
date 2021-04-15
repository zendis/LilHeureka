//
//  HomePagePresenterTests.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 15.04.2021.
//

import XCTest
@testable import LilHeureka

final class HomePagePresenterTests: XCTestCase {
    var sut: HomepagePresentationLogic = HomepagePresenter()

    // MARK: - Categories tests

    func testPresentLoadedCategoriesSuccess() throws {
        let state = HomepageScene.State()
        let response = HomepageScene.LoadCategory.Response(
            rawData: [Category(categoryId: 1, title: "Test Category 1")],
            error: nil
        )

        sut.present(loadCategories: response, in: state)
        XCTAssert(state.loadedCategories.count == 1)
        XCTAssert(state.displayedCategories.count == 2)
        XCTAssert(state.displayedCategories.first?.isDestructive == true)
        XCTAssert(state.displayedCategories.last?.isDestructive == false)
    }

    func testPresentLoadedCategoriesFailure() throws {
        let state = HomepageScene.State()
        let response = HomepageScene.LoadCategory.Response(
            rawData: nil,
            error: NetworkError.general
        )

        sut.present(loadCategories: response, in: state)
        XCTAssert(state.loadedCategories.count == 0)
        XCTAssert(state.displayedCategories.count == 1)
        XCTAssert(state.displayedCategories.first?.isDestructive == true)
    }

    // MARK: - Products tests

    func testPresentLoadedProductsSuccess() throws {
        let state = HomepageScene.State()
        let response = HomepageScene.LoadProduct.Response(
            rawData: [Product(productId: 1, title: "Test Product 1", categoryId: 1)],
            error: nil
        )

        sut.present(loadProducts: response, in: state)
        XCTAssertFalse(state.isLoadingData)
        XCTAssert(state.loadedProducts.count == 1)
        XCTAssert(state.displayedProducts.count == 1)
        XCTAssert(state.displayedProducts.first?.productId == 1)
    }

    func testPresentLoadedProductsFailure() throws {
        let state = HomepageScene.State()
        let response = HomepageScene.LoadProduct.Response(
            rawData: nil,
            error: NetworkError.general
        )

        sut.present(loadProducts: response, in: state)
        XCTAssertFalse(state.isLoadingData)
        XCTAssert(state.loadedProducts.count == 0)
        XCTAssert(state.displayedProducts.count == 0)
    }

    // MARK: - Filter tests

    func testPresentFilteredProducts() throws {
        let state = HomepageScene.State()

        // Load data
        let response = HomepageScene.LoadProduct.Response(
            rawData: [
                Product(productId: 1, title: "Test Product 1", categoryId: 1),
                Product(productId: 2, title: "Test Product 2", categoryId: 2),
                Product(productId: 3, title: "Test Product 2", categoryId: 2)
            ],
            error: nil
        )
        sut.present(loadProducts: response, in: state)

        // Filter with one category (first)
        sut.present(filterProducts: filterResponse(with: [1]), in: state)
        XCTAssert(state.loadedProducts.count == 3)
        XCTAssert(state.displayedProducts.count == 1)
        XCTAssert(state.displayedProducts.first?.productId == 1)

        // Filter with one category (second)
        sut.present(filterProducts: filterResponse(with: [2]), in: state)
        XCTAssert(state.loadedProducts.count == 3)
        XCTAssert(state.displayedProducts.count == 2)
        XCTAssert(state.displayedProducts.first?.productId == 2)
        XCTAssert(state.displayedProducts.last?.productId == 3)

        // Filter with all categories
        sut.present(filterProducts: filterResponse(with: [1, 2]), in: state)
        XCTAssert(state.loadedProducts.count == 3)
        XCTAssert(state.displayedProducts.count == 3)
        XCTAssert(state.displayedProducts.first?.productId == 1)
        XCTAssert(state.displayedProducts.last?.productId == 3)

        // Filter with non-existing category
        sut.present(filterProducts: filterResponse(with: [1000]), in: state)
        XCTAssert(state.loadedProducts.count == 3)
        XCTAssert(state.displayedProducts.count == 0)
    }

    private func filterResponse(with categories: [Int]) -> HomepageScene.FilterProduct.Reponse {
        return HomepageScene.FilterProduct.Reponse(rawData: Set(categories))
    }
}
