//
//  LuminanceView.swift
//  Ami
//
//  Created by Tom Rochat on 05/11/2022.
//

import SwiftUI

struct LuminanceView: View {
    @State private var rgbValues = RGBValues(red: 0, green: 0, blue: 0)
    @State private var luminance = 0.0
    @State private var showText = true

    @Injected(\.luminanceProvider) private var luminanceProvider
    @EnvironmentObject private var theme: ThemeManager

    private let exampleText = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, \
    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua
    """

    var body: some View {
        VStack(spacing: 8) {
            LuminanceColorSlider(value: $rgbValues.red, tintColor: .red)
            LuminanceColorSlider(value: $rgbValues.green, tintColor: .green)
            LuminanceColorSlider(value: $rgbValues.blue, tintColor: .blue)

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(rgbValues.color)
                    .frame(height: 255)

                if showText {
                    Text(exampleText)
                        .foregroundColor(.white)
                        .font(.regular(ofSize: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
            }
            .padding(.vertical, 24)

            HStack {
                Text("Luminance value is \(luminance)")
                    .foregroundColor(theme.current.text)
                    .font(.heavy(ofSize: 16))

                Spacer()
            }

            Divider()
                .padding(.vertical, 8)

            HStack {
                Text("Settings")
                    .foregroundColor(theme.current.text)
                    .font(.heavy(ofSize: 16))

                Spacer()
            }

            Toggle(isOn: $showText) {
                Text("Show text")
                    .foregroundColor(theme.current.text)
            }.tint(theme.current.primary)

            Spacer()
        }
        .padding(.horizontal, 24)
        .background(theme.current.background)
        .onChange(of: rgbValues) { _ in
            luminance = luminanceProvider.simple(red: rgbValues.red, green: rgbValues.green, blue: rgbValues.blue)
        }
    }
}

struct LuminanceView_Previews: PreviewProvider {
    static var previews: some View {
        LuminanceView()
            .environmentObject(ThemeManager())
    }
}
