//
//  TextRowView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import SwiftUI

struct TextRowView: View {
    let title: String

    // MARK: - Body

    var body: some View {
        HStack {
            Spacer()
            Text(title)
            Spacer()
        }
    }
}

#if DEBUG
struct TextRowView_Previews: PreviewProvider {
    static var previews: some View {
        TextRowView(title: "Preview text")
    }
}
#endif
