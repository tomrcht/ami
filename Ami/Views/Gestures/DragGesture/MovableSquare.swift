//
//  MovableSquare.swift
//  Ami
//
//  Created by Tom Rochat on 20/11/2022.
//

import SwiftUI

struct MovableSquare: View {
    @State private var color: Color
    @State private var position: CGPoint
    @GestureState private var latestCenterPoint: CGPoint?

    private let size: CGFloat

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged(onDrag)
            .onEnded(onDragEnded)
            .updating($latestCenterPoint) { _, value, _ in
                value = latestCenterPoint ?? position
            }
    }

    init(position: CGPoint, configuration: Configuration = .init()) {
        self.position = position
        self.color = configuration.color
        self.size = configuration.size
    }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .frame(width: size, height: size)
                    .position(position)
                    .gesture(dragGesture)
                    .onTapGesture {
                        color = .random()
                    }

                if let latestCenterPoint {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.3))
                        .frame(width: size, height: size)
                        .position(latestCenterPoint)
                }
            }
        }
    }

    private func onDrag(_ value: DragGesture.Value) {
        let xValue = latestCenterPoint?.x ?? position.x
        let yValue = latestCenterPoint?.y ?? position.y
        position = CGPoint(x: xValue + value.translation.width, y: yValue + value.translation.height)
    }

    private func onDragEnded(_ value: DragGesture.Value) {
    }
}

extension MovableSquare {
    struct Configuration {
        let size: CGFloat
        let color: Color

        init(size: CGFloat = 25, color: Color = .black) {
            self.size = size
            self.color = color
        }
    }
}

struct MovableSquare_Previews: PreviewProvider {
    static var previews: some View {
        MovableSquare(position: .zero, configuration: .init(size: 100, color: .purple))
    }
}
