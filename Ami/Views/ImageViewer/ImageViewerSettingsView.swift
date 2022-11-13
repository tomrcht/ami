//
//  ImageViewerSettingsView.swift
//  Ami
//
//  Created by Tom Rochat on 13/11/2022.
//

import SwiftUI

struct ImageViewerSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var theme: ThemeManager
    @Binding private var selectedAsset: AssetListEntry?

    private let assets: [AssetListEntry] = [
        .init(id: UUID().uuidString, name: "Bird (portrait)", assetName: Asset.birdPortrait.name),
        .init(id: UUID().uuidString, name: "Bird (square)", assetName: Asset.birdSquare.name),
        .init(id: UUID().uuidString, name: "Seoul (landscape)", assetName: Asset.seoulLandscape.name),
    ]

    init(selectedAsset: Binding<AssetListEntry?>) {
        self._selectedAsset = selectedAsset
    }

    var body: some View {
        VStack {
            List(selection: $selectedAsset) {
                ForEach(assets) { entry in
                    HStack {
                        Image(entry.assetName)
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        Text(entry.name)
                            .font(.regular(ofSize: 16))
                            .foregroundColor(theme.current.text)

                        if let selectedAsset, selectedAsset.id == entry.id {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 20)

            Button {
                dismiss()
            } label: {
                Text("Dismiss")
                    .font(.heavy(ofSize: 18))
                    .foregroundColor(theme.current.primary)
            }
        }
        .padding(.top, 24)
        .background(theme.current.background)
    }
}

struct ImageViewerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerSettingsView(selectedAsset: .constant(nil))
            .environmentObject(ThemeManager())
    }
}
