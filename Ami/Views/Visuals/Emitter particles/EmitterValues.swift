//
//  EmitterValues.swift
//  Ami
//
//  Created by Tom Rochat on 07/01/2023.
//

import Foundation

protocol EmitterValue {
    associatedtype Value: BinaryFloatingPoint
    var value: Value { get }
}

extension EmitterConfiguration {
    enum BirthRate: EmitterValue {
        case slow
        case medium
        case fast
        case custom(Float)

        var value: Float {
            switch self {
            case .slow: return 0.1
            case .medium: return 0.4
            case .fast: return 1.2
            case .custom(let value): return value
            }
        }
    }

    enum LifeTime: EmitterValue {
        case short
        case medium
        case long
        case custom(Float)

        var value: Float {
            switch self {
            case .short: return 0.2
            case .medium: return 0.4
            case .long: return 1
            case .custom(let value): return value
            }
        }
    }

    enum Velocity: EmitterValue {
        case slow
        case medium
        case fast
        case custom(CGFloat)

        var value: CGFloat {
            switch self {
            case .slow: return 0.2
            case .medium: return 0.4
            case .fast: return 1
            case .custom(let value): return value
            }
        }
    }

    enum Spread: EmitterValue {
        case narrow
        case medium
        case wide
        case custom(Double)

        var value: Double {
            switch self {
            case .narrow: return 0.2
            case .medium: return 0.4
            case .wide: return 1
            case .custom(let value): return value
            }
        }
    }
}
