//
//  ShareSheetView.swift
//  Ami
//
//  Created by Tom Rochat on 22/12/2022.
//

import SwiftUI

struct ShareSheetView: View {
    @EnvironmentObject private var theme: ThemeManager
    @State private var selectedAssetStringURL: String?

    var body: some View {
        Group {
            if let selectedAssetStringURL {
                Text("You selected asset at path : \(selectedAssetStringURL)")
                    .font(.heavy(ofSize: 14))
                    .foregroundColor(theme.current.success)
                    .padding(24)
            } else {
                Text("Use the share sheet in the gallery app with a video asset")
                    .font(.heavy(ofSize: 14))
                    .foregroundColor(theme.current.warning)
                    .padding(24)
            }
        }
        .onAppear {
            let defaults = UserDefaults(suiteName: "ami-extension")
            self.selectedAssetStringURL = defaults?.string(forKey: "selected-asset")
        }
    }
}

struct ShareSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheetView()
            .environmentObject(ThemeManager())
    }
}
