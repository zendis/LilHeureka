//
//  ProgressRowView.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 13.04.2021.
//

import SwiftUI

struct ProgressRowView: View {

    // MARK: - Body

    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

#if DEBUG
struct ProgressRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRowView()
    }
}
#endif
