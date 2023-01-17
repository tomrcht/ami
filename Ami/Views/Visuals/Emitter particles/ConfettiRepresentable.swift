//
//  ConfettiRepresentable.swift
//  Ami
//
//  Created by Tom Rochat on 07/01/2023.
//

import SwiftUI
import UIKit

struct ConfettiRepresentable: EmitterRepresentable {
    let proxy: GeometryProxy
    let renderingMode: CAEmitterLayerRenderMode = .additive
    let configuration: EmitterConfiguration

    func makeUIView(context: Context) -> some UIView {
        let view = makeBaseView()
        let layer = makeBaseLayer()
        layer.emitterCells = configuration.content.map { makeCell(content: $0) }
        view.layer.addSublayer(layer)
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }

    func makeBaseView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(configuration.backgroundColor)
        view.clipsToBounds = configuration.clipToBounds
        return view
    }

    func makeBaseLayer() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.name = "EmitterLayer"
        layer.bounds = CGRect(x: 0, y: 0, width: proxy.size.width, height: proxy.size.height)
        layer.anchorPoint = CGPoint(x: 0, y: 0)
        layer.backgroundColor = UIColor(configuration.backgroundColor).cgColor

        let verticalPosition = configuration.verticalPosition.position(in: proxy)
        layer.emitterPosition = CGPoint(x: proxy.size.width / 2, y: verticalPosition)
        layer.emitterSize = .init(width: proxy.size.width, height: 10)
        layer.fillMode = .forwards
        layer.renderMode = renderingMode
        return layer
    }

    func makeCell(content: EmitterContent) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = 1 // / content.scale
        cell.scale = 0.1
        cell.scaleRange = 0.2
        cell.scaleSpeed = 0.03
        cell.spinRange = 0.1
        cell.velocity = 1 // configuration.velocity.value
        cell.velocity = 0.2
        cell.xAcceleration = -0.2
        cell.yAcceleration = 200
        cell.zAcceleration = -50
        cell.emissionRange = 2 // configuration.spread.value
        cell.birthRate = 3 // configuration.birthRate.value
        cell.lifetime = 10 // configuration.lifeTime.value
        cell.lifetimeRange = 0.4
        cell.fillMode = .forwards
        cell.alphaRange = 0.5
        cell.alphaSpeed = 0.5
        cell.contents = content.image.cgImage
        if let color = content.color {
            cell.color = color.cgColor
        }
        return cell
    }
}
