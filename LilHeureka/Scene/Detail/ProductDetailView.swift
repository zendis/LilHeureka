//
//  ProductDetailView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var state: ProductDetailScene.State
    private let interactor: ProductDetailBusinessLogic

    // MARK: - Init

    init(state: ProductDetailScene.State) {
        self.state = state
        interactor = ProductDetailInteractor(with: state)
    }

    // MARK: - Body

    var body: some View {
        let showActionSheetBinding: Binding = Binding(
            get: { state.showActionSheet },
            set: { interactor.hideActionSheet(value: $0) }
        )

        let showAlertBinding: Binding = Binding(
            get: { state.alertItem },
            set: { interactor.closeAlert(value: $0) }
        )

        VStack {
            Text(state.product.title)
                .font(.title)
                .padding(8)

            AsyncImageView(
                state: AsyncImageView.State(
                    session: URLSession.shared,
                    url: state.mainImageUrl,
                    cache: ImageCache.shared,
                    imageDimension: 150
                )
            )

            List {
                if state.isLoadingData {
                    ProgressRowView()
                        .padding()
                } else {
                    if state.offers.isEmpty {
                        TextRowView(title: "Nejsou k dispozici žádné nabídky")
                    } else {
                        ForEach(state.offers, id: \.offerId) { offer in
                            OfferRowView(offer: offer, iconUrl: offer.imgUrl)
                                .onTapGesture {
                                    interactor.prepareActionSheet(for: offer)
                                }
                                .actionSheet(isPresented: showActionSheetBinding) {
                                    ActionSheet(
                                        title: Text("Vyberte možnost"),
                                        message: nil,
                                        buttons: state.actionSheetButtons
                                    )
                                }
                        }
                    }
                }

            }
            .animation(.easeInOut, value: state.offers)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            interactor.loadOffersFor(productId: state.product.productId)
        }
        .alert(item: showAlertBinding, content: { item in
            Alert(title: Text("Popisek"), message: Text(item.description), dismissButton: .cancel(Text("Ok")))
        })
    }
}

#if DEBUG
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(state: ProductDetailScene.State(product: Product(productId: 1, title: "Bell", categoryId: 1)))
    }
}
#endif
