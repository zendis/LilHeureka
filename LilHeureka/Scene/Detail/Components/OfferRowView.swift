//
//  OfferRowView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 14.04.2021.
//

import SwiftUI

struct OfferRowView: View {
    let offer: Offer
    let iconUrl: String?

    // MARK: - Body

    var body: some View {
        HStack {
            AsyncImageView(
                state: AsyncImageView.State(
                    session: URLSession.shared,
                    url: iconUrl,
                    cache: ImageCache.shared,
                    imageDimension: 50.0
                )
            )

            VStack(alignment: .leading) {
                Text(offer.title)
                    .fontWeight(.bold)

                Text(offer.formattedPrice)
                    .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            Spacer()
        }
        .padding()
    }
}

#if DEBUG
struct OfferRowView_Previews: PreviewProvider {
    static var previews: some View {
        OfferRowView(offer: Offer(offerId: 1, productId: 1, title: "Test", description: "Description", url: "https://google.com", imgUrl: nil, price: 100.0), iconUrl: "")
    }
}
#endif
