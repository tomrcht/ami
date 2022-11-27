//
//  DragGestureView.swift
//  Ami
//
//  Created by Tom Rochat on 20/11/2022.
//

import SwiftUI

struct DragGestureView: View {
    @State private var squareCount = 5
    @State private var hasValidSize = false

    private let squareSize: CGFloat = 50

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                ForEach(0..<squareCount, id: \.self) { _ in
                    if hasValidSize {
                        MovableSquare(
                            position: getRandomPosition(in: proxy),
                            configuration: .init(size: squareSize, color: .random())
                        )
                    }
                }

                HStack(spacing: 24) {
                    Button("Add square") {
                        squareCount += 1
                    }
                    Button("Remove square") {
                        guard squareCount > 0 else { return }
                        squareCount -= 1
                    }
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: proxy.size) { newValue in
                if !hasValidSize && newValue != .zero { hasValidSize.toggle() }
            }
        }
    }

    private func getRandomPosition(in proxy: GeometryProxy) -> CGPoint {
        guard proxy.size != .zero else {
            assertionFailure()
            return .zero
        }

        let minimumValue = squareSize / 2

        return CGPoint(
            x: CGFloat.random(in: minimumValue..<proxy.size.width),
            y: CGFloat.random(in: minimumValue..<proxy.size.height - 50) // 100% arbitrary value to avoid overlap
        )
    }
}

struct PanGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
