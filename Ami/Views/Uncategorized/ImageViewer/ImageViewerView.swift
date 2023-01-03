//
//  ImageViewerView.swift
//  Ami
//
//  Created by Tom Rochat on 13/11/2022.
//

import SwiftUI

struct ImageViewerView: View {
    #if DEBUG
    @State private var asset: AssetListEntry? = AssetListEntry(
        id: UUID().uuidString,
        name: "mock",
        assetName: Asset.seoulLandscape.name
    )
    #else
    @State private var asset: AssetListEntry? = nil
    #endif
    @State private var showConfigurationSheet = false
    @EnvironmentObject private var theme: ThemeManager

    // Image viewer state properties
    @State private var scaleFactor: CGFloat = 1
    @State private var lastScaleFactor: CGFloat = 1

    private let minScaleFactor: CGFloat = 1
    private let maxScaleFactor: CGFloat = 5

    private var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged(onMagnificationStarted)
            .onEnded(onMagnificationEnded)
    }

    // MARK: - Views
    var body: some View {
        Group {
            if let asset {
                ZStack(alignment: .topTrailing) {
                    Color.black
                        .ignoresSafeArea(edges: .vertical)
                    contentView(asset: asset)
                    Button {
                        showConfigurationSheet.toggle()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(theme.current.primary)
                    }
                }
            } else {
                emptyStateView
            }
        }
        .sheet(isPresented: $showConfigurationSheet) { ImageViewerSettingsView(selectedAsset: $asset) }
    }

    private var emptyStateView: some View {
        Button {
            showConfigurationSheet.toggle()
        } label: {
            Text("Select an image to start :)")
                .font(.regular(ofSize: 16))
                .foregroundColor(theme.current.primary)
        }
    }

    private func contentView(asset: AssetListEntry) -> some View {
        GeometryReader { proxy in
            ScrollView([.vertical, .horizontal], showsIndicators: false) {
                Image(asset.assetName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture(count: 2, perform: onImageDoubleTapped)
                    .gesture(scaleGesture)
                    .frame(width: proxy.size.width * max(minScaleFactor, scaleFactor))
                    .frame(maxHeight: .infinity)
            }
        }
    }

    // MARK: - Image manipulation methods
    private func onImageDoubleTapped() {
        if scaleFactor == minScaleFactor {
            withAnimation(.interactiveSpring()) {
                scaleFactor = maxScaleFactor
            }
        } else {
            resetImageScale()
        }
    }

    private func onMagnificationStarted(_ value: MagnificationGesture.Value) {
        withAnimation(.easeIn(duration: 0.1)) {
            let delta = value / lastScaleFactor
            lastScaleFactor = value
            let scaleDelta = scaleFactor * delta
            let newScaleFactor = min(maxScaleFactor, max(minScaleFactor, scaleDelta))
            scaleFactor = newScaleFactor
        }
    }

    private func onMagnificationEnded(_ value: MagnificationGesture.Value) {
        lastScaleFactor = minScaleFactor
        if scaleFactor < minScaleFactor {
            resetImageScale()
        } else if scaleFactor > maxScaleFactor {
            scaleFactor = maxScaleFactor
        }
    }

    private func resetImageScale() {
        withAnimation(.interactiveSpring()) {
            scaleFactor = minScaleFactor
        }
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView()
            .environmentObject(ThemeManager())
    }
}
