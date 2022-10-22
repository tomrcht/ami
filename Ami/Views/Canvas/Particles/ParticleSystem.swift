//
//  ParticleSystem.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import SwiftUI

final class ParticleSystem {
    var particles: [Particle]

    init(particles: [Particle]) {
        self.particles = particles
    }

    convenience init() {
        self.init(particles: [])
    }

    convenience init(count: Int) {
        self.init(particles: [])

        for _ in 0..<count {
            let particle = Particle(
                id: UUID().uuidString,
                color: Color.random(),
                size: 8
            )
            particles.append(particle)
        }
    }
}
