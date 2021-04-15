//
//  Debugger.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import Foundation

struct Debugger {
    let isDebug: Bool = {
        var isDebug = false
        // function with a side effect and Bool return value that we can pass into assert()
        func set(debug: Bool) -> Bool {
            isDebug = debug
            return isDebug
        }
        // assert:
        // "Condition is only evaluated in playgrounds and -Onone builds."
        // so isDebug is never changed to true in Release builds
        assert(set(debug: true))
        return isDebug
    }()

    // MARK: - Log

    public func log(_ string: String) {
        if isDebug {
            print("\(string)")
        }
    }

    func logRequest(_ request: URLRequest) {
        if isDebug {
            print("🔵 Request: \(request.url?.absoluteString ?? "") - (\(String(describing: request.httpMethod))")
            print("Request headers: \(String(describing: request.allHTTPHeaderFields as AnyObject))")

            guard let data = request.httpBody else { return }
            try? print("Request body: \(String(describing: JSONSerialization.jsonObject(with: data, options: []) as AnyObject))")
        }
    }

    func logResponse(url: String?, statusCode: Int, headers: [AnyHashable: Any], data: Data?) {
        if isDebug {
            guard let data = data else { return }

            print("🎉 Response: Status = \(statusCode), \(url ?? "NO_URL")")
            print("Response headers: \(String(describing: headers as AnyObject))")

            if let jsonString = prettyPrintedJson(from: data) {
                print("Response JSON: \(jsonString)")
            }
            print("\n\n")
        }
    }

    // MARK: - Pretty printed json

    private func prettyPrintedJson(from data: Data) -> NSString? {
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
            let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }
        return result
    }
}
