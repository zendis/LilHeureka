//
//  AsyncImageView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 14.04.2021.
//

import SwiftUI

struct AsyncImageView: View {
    @ObservedObject var state: AsyncImageView.State

    // MARK: - Init

    init(state: AsyncImageView.State) {
        self.state = state
        self.state.loadImage()
    }

    // MARK: - Body

    var body: some View {
        if let image = state.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: state.imageDimension, height: state.imageDimension)
        } else {
            Image(systemName: state.systemNamePlaceholder)
                .resizable()
                .scaledToFit()
                .frame(width: state.imageDimension, height: state.imageDimension)
        }
    }
}

// MARK: - State

extension AsyncImageView {
    final class State: ObservableObject {
        @Published var image: UIImage?

        let systemNamePlaceholder: String
        let imageDimension: CGFloat
        private let provider: ImageProvider
        private let url: String?
        private let cache: ImageCache

        // MARK: - Init

        init(session: URLSession, url: String?, cache: ImageCache, systemNamePlaceholder: String = "photo", imageDimension: CGFloat = 80.0) {
            self.provider = ImageProvider(with: session)
            self.cache = cache
            self.url = url
            self.systemNamePlaceholder = systemNamePlaceholder
            self.imageDimension = imageDimension
        }

        // MARK: - Load

        func loadImage() {
            guard let url = url else { return }

            if let cachedImage = cache.getImageFor(url: url) {
                image = cachedImage
                return
            }

            provider.loadImageFrom(url: url) { image in
                DispatchQueue.main.async {
                    if let image = image {
                        self.cache.set(image: image, forUrl: url)
                        self.image = image
                    }
                }
            }
        }
    }
}

#if DEBUG
struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        let session: URLSession = URLSession.shared
        let url: String = "https://www.autoweb.cz/wp-content/uploads/2020/01/bmw-m8_competition_coupe-2020-1600-1e-1100x618.jpg"
        AsyncImageView(state: AsyncImageView.State(session: session, url: url, cache: ImageCache.shared))
    }
}
#endif
