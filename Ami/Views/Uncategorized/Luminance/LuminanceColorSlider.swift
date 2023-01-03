//
//  LuminanceColorSlider.swift
//  Ami
//
//  Created by Tom Rochat on 05/11/2022.
//

import SwiftUI

struct LuminanceColorSlider: View {
    @Binding private var value: Double
    private let tintColor: Color

    init(value: Binding<Double>, tintColor: Color) {
        self._value = value
        self.tintColor = tintColor
    }

    var body: some View {
        HStack {
            VStack(spacing: 8) {
                Slider(value: $value, in: 0...255, step: 1) { _ in }
                    .tint(tintColor)
                Text("\(value, format: .number)")
                    .foregroundColor(tintColor)
                    .font(.heavy(ofSize: 14))
            }
        }
    }
}

struct LuminanceColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LuminanceColorSlider(value: .constant(0.0), tintColor: .yellow)
                .padding(24)
            LuminanceColorSlider(value: .constant(50.0), tintColor: .green)
                .padding(24)
            LuminanceColorSlider(value: .constant(255.0), tintColor: .purple)
                .padding(24)
        }
    }
}
