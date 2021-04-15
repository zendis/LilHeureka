//
//  NetworkConnectTests.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import XCTest
@testable import LilHeureka

final class NetworkConnectTests: XCTestCase {
    private var sut: NetworkConnectable {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let sessionMock = URLSession(configuration: config)

        return NetworkConnect(with: sessionMock)
    }

    // MARK: - Tests

    func testSuccesfullRequest() throws {
        let request = URLRequest(with: ApiRequestConfiguration(host: NetworkConstantsMock.host, httpEndpointPath: "/categories"))
        sut.loadApiEndpoint(with: request) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
        }
    }

    func testFailedRequest() throws {
        let request = URLRequest(with: ApiRequestConfiguration(host: NetworkConstantsMock.host, httpEndpointPath: "/categories/failure"))
        sut.loadApiEndpoint(with: request) { result in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure:
                XCTAssert(true)
            }
        }
    }
}
