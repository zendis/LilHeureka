//
//  ClearColorButtonStyle.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 12.04.2021.
//

import SwiftUI

struct ClearColorButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.black)
            .background(Color.clear)
    }
}
