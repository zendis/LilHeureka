//
//  ImageProvider.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 14.04.2021.
//

import UIKit

final class ImageProvider: Provider {

    // MARK: - Load image

    func loadImageFrom(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return completion(nil) }
        
        networkConnect.load(with: URLRequest(url: url)) { (data, error) in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }
    }
}
