//
//  EmitterView.swift
//  Ami
//
//  Created by Tom Rochat on 07/01/2023.
//

import SwiftUI

struct EmitterView: View {
    let configuration = EmitterConfiguration(
        verticalPosition: .ratio(0.3),
        content: Set([
            .shape(.circle, color: .purple, scale: 1),
            .shape(.square, color: .red, scale: 1),
            .shape(.triangle, color: .green, scale: 1),
        ]),
        backgroundColor: .black
    )

    var body: some View {
        GeometryReader { proxy in
            ConfettiRepresentable(proxy: proxy, configuration: configuration)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmitterView_Previews: PreviewProvider {
    static var previews: some View {
        EmitterView()
    }
}
