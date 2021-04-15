//
//  HomepageView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 11.04.2021.
//

import SwiftUI

struct HomepageView: View {
    @ObservedObject private var state: HomepageScene.State
    private let interactor: HomepageBusinessLogic

    // MARK: - Init

    init(state: HomepageScene.State) {
        self.state = state
        interactor = HomepageInteractor(with: state)
    }

    // MARK: - Body

	var body: some View {
        let selectedCategoriesBinding: Binding = Binding(
            get: { state.selectedCategories },
            set: { interactor.filterProductsWith(selectedCategories: $0) }
        )

        NavigationView {
            List {
                if state.isLoadingData {
                    ProgressRowView()
                        .padding()
                } else {
                    FilterRowView(data: state.displayedCategories, selectedItems: selectedCategoriesBinding)
                        .background(Color(.systemGray6))
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .animation(.none)

                    if state.displayedProducts.isEmpty {
                        TextRowView(title: "Nejsou k dispozici žádné produkty")
                    } else {
                        ForEach(state.displayedProducts, id: \.productId) { product in
                            NavigationLink(
                                destination: ProductDetailView(state: ProductDetailScene.State(product: product)),
                                label: {
                                    ProductRowView(product: product)
                                }
                            )
                        }
                    }
                }
            }
            .animation(.easeInOut, value: state.displayedProducts)
            .navigationTitle("Produkty")
        }
        .onAppear() {
            interactor.loadCategoriesAndProducts()
        }
    }
}

#if DEBUG
struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView(
            state: HomepageScene.State()
        )
    }
}
#endif
