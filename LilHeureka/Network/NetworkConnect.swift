//
//  NetworkConnect.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

protocol NetworkConnectable {
    typealias RequestCompletion = (Result<Data?, NetworkError>) -> Void

    init(with session: URLSession)
    func loadApiEndpoint(with request: URLRequest, completion: @escaping RequestCompletion)
    func load(with request: URLRequest, completion: @escaping (Data?, NetworkError?) -> Void)
}

struct NetworkConnect: NetworkConnectable {
    private let successfullStatusCodes: Set<Int> = Set(200 ..< 300)
    private let debugger: Debugger = Debugger()
    private let session: URLSession

    // MARK: - Init

    init(with session: URLSession) {
        self.session = session
    }

    // MARK: - Load data from API

    func loadApiEndpoint(with request: URLRequest, completion: @escaping RequestCompletion) {
        debugger.logRequest(request)

        session.dataTask(with: request, completionHandler: { (data, response, error) in
            let httpUrlResponse: HTTPURLResponse? = response as? HTTPURLResponse
            let statusCode: Int = httpUrlResponse?.statusCode ?? -1
            let headers: [AnyHashable: Any] = httpUrlResponse?.allHeaderFields ?? [:]

            debugger.logResponse(url: request.url?.absoluteString, statusCode: statusCode, headers: headers, data: data)

            if successfullStatusCodes.contains(statusCode) {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.general))
            }
        }).resume()
    }

    // MARK: - Load data from url

    func load(with request: URLRequest, completion: @escaping (Data?, NetworkError?) -> Void) {
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? -1
            if successfullStatusCodes.contains(statusCode) {
                completion(data, nil)
            } else {
                completion(nil, NetworkError.general)
            }
        }).resume()
    }
}
