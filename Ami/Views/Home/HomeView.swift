//
//  HomeView.swift
//  Ami
//
//  Created by Tom Rochat on 15/10/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var theme: ThemeManager

    var body: some View {
        NavigationStack {
            List {
                Section("View / Animations / Transitions") {
                    NavigationLink {
                        TransitionsView()
                    } label: {
                        label("Transitions", systemIcon: "arrowshape.zigzag.forward")
                    }

                    NavigationLink {
                        AnimationsView()
                    } label: {
                        label("Animations", systemIcon: "wand.and.stars")
                    }

                    NavigationLink {
                        StackAnimationView()
                    } label: {
                        label("Stack animation", systemIcon: "square.stack.3d.up.fill")
                    }

                    NavigationLink {
                        CanvasView()
                    } label: {
                        label("Canvas", systemIcon: "paintpalette")
                    }

                    NavigationLink {
                        EmitterView()
                    } label: {
                        label("Particles emitter", systemIcon: "sparkles")
                    }
                }

                Section("Gestures") {
                    NavigationLink {
                        DragGestureView()
                    } label: {
                        label("Drag gesture", systemIcon: "hand.draw.fill")
                    }
                }

                Section("Other") {
                    NavigationLink {
                        LuminanceView()
                    } label: {
                        label("Luminance", systemIcon: "rays")
                    }

                    NavigationLink {
                        ShareSheetView()
                    } label: {
                        label("Share sheet", systemIcon: "square.and.arrow.up")
                    }

                    NavigationLink {
                        ImageViewerView()
                    } label: {
                        label("[KO] Image viewer", systemIcon: "photo.artframe")
                    }
                    .disabled(true)
                }
            }
        }
    }

    private func label(_ title: any StringProtocol, systemIcon: String) -> some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: systemIcon)
                .foregroundColor(theme.current.primary)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ThemeManager())
    }
}
