//
//  JsonResponseParser.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

protocol ResponseParserable {
    func parse<T: Decodable>(data: Data, into model: T.Type) -> T?
}

struct JsonResponseParser: ResponseParserable {
    private let debugger: Debugger = Debugger()

    // MARK: - Parse

    func parse<T: Decodable>(data: Data, into model: T.Type) -> T? {
        let decoder = JSONDecoder()

        do {
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch let error {
            debugger.log("JSON Decodable error: \(error)")
            return nil
        }
    }
}
