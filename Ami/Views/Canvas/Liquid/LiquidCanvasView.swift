//
//  LiquidCanvasView.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import SwiftUI

struct LiquidCanvasView: View {
    @State private var offset: CGSize = .zero

    // Center our symbols in the canvas
    private let origin = UnitPoint.center

    var body: some View {
        Canvas { context, size in
            // Treat any pixel with an opacity > `min` as a solid color
            // This means that instead of rendering blurred pixels (with a lower opacity), we will have a solid color
            context.addFilter(.alphaThreshold(min: 0.5, color: .purple))
            context.addFilter(.blur(radius: 40.0))

            context.drawLayer { layerContext in
                for index in 0..<2 {
                    if let resolvedSymbol = context.resolveSymbol(id: index) {
                        let position = CGPoint(
                            x: origin.x * size.width,
                            y: origin.y * size.height
                        )
                        layerContext.draw(resolvedSymbol, at: position)
                    }
                }
            }
        } symbols: {
            liquidShape(ofSize: 112, offset: offset.applying(.init(scaleX: 0.1, y: 0.1))).tag(0)
            liquidShape(ofSize: 112, offset: offset).tag(1)
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.55, blendDuration: 0.25)) {
                        self.offset = .zero
                    }
                }
        )
    }

    @ViewBuilder
    private func liquidShape(ofSize size: CGFloat, offset: CGSize = .zero) -> some View {
        Circle()
            .frame(width: size, height: size)
            .offset(offset)
    }
}

struct LiquidCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        LiquidCanvasView()
    }
}
