//
//  HomeView.swift
//  Ami
//
//  Created by Tom Rochat on 15/10/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .font(.title)
                .foregroundColor(themeManager.current.mainColor)
                .onTapGesture {
                    themeManager.changeTheme(to: .red)
                }

            Text("Ami")
                .font(.heavy(ofSize: 16))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ThemeManager())
    }
}
