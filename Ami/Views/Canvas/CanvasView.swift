//
//  CanvasView.swift
//  Ami
//
//  Created by Tom Rochat on 19/10/2022.
//

import SwiftUI

struct CanvasView: View {
    @State private var animationPaused = false

    var body: some View {
        VStack {
            Spacer()

            TimelineView(.animation(minimumInterval: nil, paused: animationPaused)) { timelineContext in
                LiquidCanvasView()
            }

            Spacer()

            Button(animationPaused ? "Play" : "Pause") { animationPaused.toggle() }
                .padding(.bottom, 56)
        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
