//
//  GradientCanvasView.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import SwiftUI

struct GradientCanvasView: View {
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let font = Font.heavy(ofSize: 24)
            let shadingView = Text("Kind of a canvas drawing!").font(font)

            var resolved = context.resolve(shadingView)

            let startPoint = CGPoint(x: size.width - resolved.measure(in: size).width / 2, y: 0)
            let endPoint = CGPoint(x: size.width - startPoint.x, y: 0)

            resolved.shading = .linearGradient(
                Gradient(colors: [.pink, .purple]), startPoint: startPoint, endPoint: endPoint
            )

            context.draw(resolved, at: center, anchor: .center)
        }
    }
}
