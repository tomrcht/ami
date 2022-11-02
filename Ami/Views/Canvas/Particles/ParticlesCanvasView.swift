//
//  ParticlesCanvasView.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import SwiftUI

struct ParticlesCanvasView: View {
    private let particleSystem = ParticleSystem(count: 150)

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                particleSystem.tick(at: timeline.date.timeIntervalSinceReferenceDate)

                for particle in particleSystem.particles {
                    let posX = particle.origin.x * size.width + particle.getOffsetX(at: timeline.date.timeIntervalSinceReferenceDate)
                    let posY = particle.origin.y * size.height + particle.getOffsetY(at: timeline.date.timeIntervalSinceReferenceDate)
                    let drawPoint = CGPoint(x: posX, y: posY)

                    guard let symbol = context.resolveSymbol(id: particle.id) else {
                        assertionFailure()
                        return
                    }
                    context.draw(symbol, at: drawPoint)
                }
            } symbols: {
                ForEach(Array(particleSystem.particles), id: \.id) { particle in
                    particle
                        .view
                        .tag(particle.id)
                }
            }
        }
    }
}

struct ParticlesCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        ParticlesCanvasView()
    }
}
