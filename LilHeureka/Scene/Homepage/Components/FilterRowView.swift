//
//  FilterHeaderView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 12.04.2021.
//

import SwiftUI

struct FilterRowView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var data: [FilterRowView.Item]
    @Binding var selectedItems: Set<Int>

    private let selectedColor: Color = Color( red: 117.0 / 255.0, green: 223.0 / 255.0, blue: 255.0 / 255.0, opacity: 1.0)

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .top) {
                ForEach(data, id: \.id) { item in
                    Button(action: {
                        guard !item.isDestructive else {
                            selectedItems.removeAll()
                            return
                        }

                        if !selectedItems.insert(item.id).inserted {
                            selectedItems.remove(item.id)
                        }
                    }) {
                        VStack {
                            Image(item.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(14)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))

                            Text(item.title)
                                .font(.system(size: 13.0))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(height: 40)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                    .frame(width: 80, height: 110)
                    .padding()
                    .background(isSelected(item: item) ? selectedColor : Color.clear)
                    .buttonStyle(ClearColorButtonStyle())
                    .cornerRadius(10)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        })
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .animation(.none)
    }

    // MARK: - Is item selected

    func isSelected(item: FilterRowView.Item) -> Bool {
        guard !selectedItems.isEmpty else { return item.isDestructive }
        return selectedItems.contains(item.id)
    }
}

extension FilterRowView {
    struct Item {
        let id: Int
        let title: String
        let iconName: String
        let isDestructive: Bool
    }
}

#if DEBUG
struct FilterHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let data: [FilterRowView.Item] = [
            FilterRowView.Item(id: 1, title: "Vše", iconName: "IconAll", isDestructive: true),
            FilterRowView.Item(id: 2, title: "Bell", iconName: "IconBell", isDestructive: false),
            FilterRowView.Item(id: 3, title: "Phone", iconName: "IconTelephone", isDestructive: false),
            FilterRowView.Item(id: 4, title: "Plant", iconName: "IconPlant", isDestructive: false)
        ]
        FilterRowView(data: data, selectedItems: .constant(Set()))
    }
}
#endif
