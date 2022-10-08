//
//  RootView.swift
//  Ami
//
//  Created by Tom Rochat on 06/10/2022.
//

import SwiftUI

struct RootView: View {
    @Injected(\.helloProvider) private var hello: any HelloProviding
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        Image(systemName: "heart.fill")
            .font(.title)
            .foregroundColor(themeManager.current.mainColor)
            .onTapGesture {
                themeManager.changeTheme(to: .red)
            }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
