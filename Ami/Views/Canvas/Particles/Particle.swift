//
//  Particle.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import Foundation
import SwiftUI

struct Particle: Identifiable, Hashable {
    /// The ID identifying this particle
    let id: String

    // MARK: - Particle visual properties

    /// Size of the rendered particle
    let size: Double
    /// Color of the rendered particle
    let color: Color

    // MARK: - """Existential""" properties

    /// Time of creation of this particle
    let spawnTime = Date.now.timeIntervalSinceReferenceDate
    /// Duration for which this particle should stay alive
    let lifeTime: TimeInterval
    /// Spawn-point of this particle
    let origin: UnitPoint
    /// Velocity of the particle, used to calculate its offset
    let velocity: Double
    /// Direction in which the particle should move when the system ticks
    let direction: Double

    /// The rendered view, resolved via `GraphicsContext.resolve`
    var view: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
    }

    /// Get the current horizontal offset of this particle, based on the current rendering time
    ///
    /// - Parameters:
    ///     - time: The current rendering time
    /// - Returns: The horizontal offset at the given time
    func getOffsetX(at time: TimeInterval) -> Double {
        let delta = time - spawnTime
        return velocity * cos(direction) * delta
    }

    /// Get the current vertical offset of this particle, based on the current rendering time
    ///
    /// - Parameters:
    ///     - time: The current rendering time
    /// - Returns: The vertical offset at the given time
    func getOffsetY(at time: TimeInterval) -> Double {
        let delta = time - spawnTime
        return velocity * sin(direction) * delta
    }
}
