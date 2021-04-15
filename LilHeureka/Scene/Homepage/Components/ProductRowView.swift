//
//  ProductRowView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 12.04.2021.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product
    let icon: Image

    // MARK: - Init

    init(product: Product, icon: Image = Image(systemName: "photo")) {
        self.product = product
        self.icon = icon
    }

    // MARK: - Body

    var body: some View {
        HStack {
            icon
            Text(product.title)
            Spacer()
        }
        .padding()
    }
}

#if DEBUG
struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: Product(productId: 1, title: "Preview title", categoryId: 1), icon: Image(systemName: "photo.tv"))
    }
}
#endif
