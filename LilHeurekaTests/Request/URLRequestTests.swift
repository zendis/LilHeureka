//
//  URLRequestTests.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import XCTest
@testable import LilHeureka

final class URLRequestTests: XCTestCase {

    // MARK: - Tests

    func testRequestWithEndpoint() throws {
        let configuration: ApiRequestConfiguration = ApiRequestConfiguration(httpMethod: .get, host: NetworkConstantsMock.host, httpEndpointPath: "/categories")
        let sut = URLRequest(with: configuration)

        XCTAssert(sut.url?.absoluteString == "https://fakeApi.com/categories")
        XCTAssert(sut.httpMethod == "GET")
    }

    func testRequestWithEmptyEndpoint() throws {
        let configuration: ApiRequestConfiguration = ApiRequestConfiguration(httpMethod: .post, host: NetworkConstantsMock.host, httpEndpointPath: "")
        let sut = URLRequest(with: configuration)

        XCTAssert(sut.url?.absoluteString == "https://fakeApi.com")
        XCTAssert(sut.httpMethod == "POST")
    }
}
