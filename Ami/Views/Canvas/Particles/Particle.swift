//
//  Particle.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import Foundation
import SwiftUI

struct Particle: Identifiable {
    typealias ID = String

    let id: ID

    let color: Color
    let size: CGFloat
}

struct ParticleView: View {
    let color: Color
    let size: CGFloat

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
    }
}
