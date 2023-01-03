//
//  ParticleSystem.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import SwiftUI

final class ParticleSystem {
    private(set) var particles: Set<Particle>

    init(particles: Set<Particle>) {
        self.particles = particles
    }

    convenience init() {
        self.init(particles: Set<Particle>())
    }

    convenience init(count: Int) {
        self.init(particles: Set<Particle>())
        for _ in 0..<count {
            let particle = Particle(
                id: UUID().uuidString,
                size: .random(in: 2...8),
                color: .random(),
                lifeTime: .random(in: 2...5),
                origin: .center,
                velocity: .random(in: 10...200),
                direction: .random(in: -Double.pi...Double.pi)
            )
            particles.insert(particle)
        }
    }

    func addParticle(_ particle: Particle) {
        particles.insert(particle)
    }

    func tick(at time: TimeInterval) {
        for particle in particles {
            manageLifeTime(for: particle, currentTime: time)
        }
    }

    private func manageLifeTime(for particle: Particle, currentTime: TimeInterval) {
        let existentialTime = currentTime - particle.spawnTime
        if existentialTime >= particle.lifeTime {
            particles.remove(particle)
        }
    }
}
