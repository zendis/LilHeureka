//
//  ImageCache.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 14.04.2021.
//

import UIKit

final class ImageCache {
    static let shared: ImageCache = ImageCache()
    private var cache: NSCache<NSString, UIImage> = NSCache()

    // MARK: - init

    private init() {}

    // MARK: - Get image

    func getImageFor(url: String) -> UIImage? {
        return cache.object(forKey: NSString(string: url))
    }

    // MARK: - Set image

    func set(image: UIImage, forUrl url: String) {
        cache.setObject(image, forKey: NSString(string: url))
    }
}
