//
//  URLProtocolMock.swift
//  LilHeurekaTests
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

final class URLProtocolMock: URLProtocol {

    // MARK: - Can init

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // MARK: - Canonical request

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    // MARK: - Start loading

    override func startLoading() {
        switch request.url?.path {
        case "/categories":
            if let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = "[{\"id\": 1, \"name\": \"Test\", \"tagId\": 25}, {\"id\": 2, \"name\": \"Test 2\", \"tagId\": 26}]".data(using: .utf8) {
                client?.urlProtocol(self, didLoad: data)
            }
        case "/categories/failure":
            if let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = "{\"error\": \"Bad Request\"}".data(using: .utf8) {
                client?.urlProtocol(self, didLoad: data)
            }
        default:
            break
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    // MARK: - Stop loading

    override func stopLoading() { }
}
