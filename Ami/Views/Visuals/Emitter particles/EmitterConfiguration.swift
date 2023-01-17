//
//  EmitterConfiguration.swift
//  Ami
//
//  Created by Tom Rochat on 07/01/2023.
//

import Foundation
import SwiftUI

struct EmitterConfiguration {
    let verticalPosition: VerticalPosition
    let clipToBounds: Bool

    let content: Set<EmitterContent>
    let backgroundColor: Color

    let birthRate: BirthRate
    let lifeTime: LifeTime
    let velocity: Velocity
    let spread: Spread

    init(
        verticalPosition: VerticalPosition,
        clipToBounds: Bool = true,
        content: Set<EmitterContent>,
        backgroundColor: Color,
        birthRate: BirthRate = .medium,
        lifeTime: LifeTime = .medium,
        velocity: Velocity = .medium,
        spread: Spread = .medium
    ) {
        self.verticalPosition = verticalPosition
        self.clipToBounds = clipToBounds
        self.content = content
        self.backgroundColor = backgroundColor
        self.birthRate = birthRate
        self.lifeTime = lifeTime
        self.velocity = velocity
        self.spread = spread
    }
}

extension EmitterConfiguration {
    enum VerticalPosition {
        case top
        case middle
        case bottom
        case exact(CGFloat)
        case ratio(CGFloat)

        func position(in proxy: GeometryProxy) -> CGFloat {
            switch self {
            case .top:
                return 0
            case .middle:
                return proxy.size.height / 2
            case .bottom:
                return proxy.size.height
            case .exact(let value):
                return value
            case .ratio(let value):
                assert((0...1).contains(value), "Position ratio value must be between 0 and 1")
                return proxy.size.height * value
            }
        }
    }
}
