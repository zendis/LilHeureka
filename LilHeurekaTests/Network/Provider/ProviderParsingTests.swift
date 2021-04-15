//
//  ProviderParsingTests.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import XCTest
@testable import LilHeureka

final class ProviderParsingTests: XCTestCase {
    private var sut: CategoryProviderMock {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let sessionMock = URLSession(configuration: config)

        let networkConnect: NetworkConnectable = NetworkConnect(with: sessionMock)
        return CategoryProviderMock(networkConnect: networkConnect, parser: JsonResponseParser())
    }

    // MARK: - Tests

    func testJsonParsing() throws {
        sut.loadCategories { categories in
            XCTAssert(categories?.count == 2)

            XCTAssert(categories?.first?.id == 1)
            XCTAssert(categories?.first?.name == "Test")
            XCTAssert(categories?.first?.tagId == 25)

            XCTAssert(categories?.last?.id == 2)
            XCTAssert(categories?.last?.name == "Test 2")
            XCTAssert(categories?.last?.tagId == 26)
        }
    }
}
