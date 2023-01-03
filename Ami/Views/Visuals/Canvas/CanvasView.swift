//
//  CanvasView.swift
//  Ami
//
//  Created by Tom Rochat on 19/10/2022.
//

import SwiftUI

struct CanvasView: View {
    var body: some View {
//        GradientCanvasView()

        ParticlesCanvasView()

//        LiquidCanvasView()
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
