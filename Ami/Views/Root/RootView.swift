//
//  RootView.swift
//  Ami
//
//  Created by Tom Rochat on 06/10/2022.
//

import SwiftUI

struct RootView: View {
    @State private var page: Page = .home
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        ZStack {
            Group {
                switch page {
                case .home:
                    HomeView()
                case .settings:
                    SettingsView()
                }
            }

//            VStack {
//                Spacer()
//                AmiTabBar(selection: $page)
//                    .padding(.horizontal, 24)
//            }
        }
        .background(themeManager.current.background)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(ThemeManager(defaultTheme: Themes.default.value))
    }
}
