//
//  LilHeurekaApp.swift
//  LilHeureka
//
//  Created by Zdenek Plesník on 09.04.2021.
//

import SwiftUI

@main
struct LilHeurekaApp: App {
    var body: some Scene {
        WindowGroup {
            HomepageView(state: HomepageScene.State())
        }
    }
}
