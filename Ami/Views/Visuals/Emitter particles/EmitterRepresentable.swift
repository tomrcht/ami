//
//  EmitterRepresentable.swift
//  Ami
//
//  Created by Tom Rochat on 07/01/2023.
//

import SwiftUI
import UIKit

protocol EmitterRepresentable: UIViewRepresentable {
    var proxy: GeometryProxy { get }
    var renderingMode: CAEmitterLayerRenderMode { get }
    var configuration: EmitterConfiguration { get }

    func makeBaseView() -> UIView
    func makeBaseLayer() -> CAEmitterLayer
    func makeCell(content: EmitterContent) -> CAEmitterCell
}
