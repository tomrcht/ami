//
//  AmiApp.swift
//  Ami
//
//  Created by Tom Rochat on 06/10/2022.
//

import SwiftUI

@main
struct AmiApp: App {
    @StateObject private var themeManager = ThemeManager(defaultTheme: PurpleTheme())

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(themeManager)
        }
    }
}
