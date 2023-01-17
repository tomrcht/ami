//
//  EmitterContent.swift
//  Ami
//
//  Created by Tom Rochat on 07/01/2023.
//

import CoreGraphics
import Foundation
import UIKit

enum EmitterShape: Hashable {
    case circle
    case triangle
    case square
    case custom(CGPath)

    func path(in rect: CGRect) -> CGPath {
        switch self {
        case .circle:
            return CGPath(ellipseIn: rect, transform: nil)
        case .triangle:
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: rect.midX, y: 0),
                CGPoint(x: rect.maxX, y: rect.maxY),
                CGPoint(x: rect.minX, y: rect.maxY),
                CGPoint(x: rect.midX, y: 0),
            ])
            return path
        case .square:
            return CGPath(rect: rect, transform: nil)
        case .custom(let path):
            return path
        }
    }

    func image(with color: UIColor) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 12, height: 12))
        return UIGraphicsImageRenderer(size: rect.size).image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.addPath(path(in: rect))
            context.cgContext.fillPath()
        }
    }
}

enum EmitterContent: Hashable {
    case shape(EmitterShape, color: UIColor, scale: CGFloat = 1)
    case image(UIImage, scale: CGFloat = 1)

    var color: UIColor? {
        if case let .shape(_, color, _) = self {
            return color
        }
        return nil
    }

    var image: UIImage {
        switch self {
        case .shape(let emitterShape, let color, _):
            return emitterShape.image(with: color)
        case .image(let image, _):
            return image
        }
    }

    var scale: CGFloat {
        switch self {
        case .shape(_, _, let scale):
            return scale
        case .image(_, let scale):
            return scale
        }
    }
}
