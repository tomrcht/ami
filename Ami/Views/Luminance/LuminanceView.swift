//
//  LuminanceView.swift
//  Ami
//
//  Created by Tom Rochat on 05/11/2022.
//

import SwiftUI

private enum LuminanceAlgorithm: Identifiable, Equatable {
    case simple
    case complex

    var id: Self { self }
}

private enum TextColor: Identifiable, Equatable {
    case auto
    case light
    case dark

    var id: Self { self }
}

struct LuminanceView: View {
    @State private var rgbValues = RGBValues(red: 0, green: 0, blue: 0)
    @State private var luminance = 0.0
    @State private var perceivedLightness = 0.0

    @State private var algorithm = LuminanceAlgorithm.simple
    @State private var textColor = TextColor.auto
    @State private var showText = true

    @Injected(\.luminanceProvider) private var luminanceProvider
    @EnvironmentObject private var theme: ThemeManager

    private let threshold = 0.179
    private let sampleText = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, \
    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua
    """

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                // MARK: - Colors + render
                LuminanceColorSlider(value: $rgbValues.red, tintColor: .red)
                LuminanceColorSlider(value: $rgbValues.green, tintColor: .green)
                LuminanceColorSlider(value: $rgbValues.blue, tintColor: .blue)

                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(rgbValues.color)
                        .frame(height: 255)

                    if showText {
                        Text(sampleText)
                            .foregroundColor(getSampleTextColor())
                            .font(.regular(ofSize: 20))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                }
                .padding(.vertical, 24)

                // MARK: - informations
                infoView

                Divider().padding(.vertical, 8)

                // MARK: - Settings
                settingsView

                Spacer()
            }
        }
        .padding(.horizontal, 24)
        .background(theme.current.background)
        .onChange(of: rgbValues) { _ in
            let red = rgbValues.red / 255
            let green = rgbValues.green / 255
            let blue = rgbValues.blue / 255

            if algorithm == .simple {
                luminance = luminanceProvider.simple(red: red, green: green, blue: blue)
            } else {
                luminance = luminanceProvider.complex(red: red, green: green, blue: blue)
                perceivedLightness = luminanceProvider.perceivedLightness(luminance: luminance)
            }
        }
    }

    private var infoView: some View {
        VStack {
            HStack {
                Text("Luminance value is \(luminance)")
                    .foregroundColor(theme.current.text)
                    .font(.heavy(ofSize: 16))
                Spacer()
            }

            if algorithm == .complex {
                HStack {
                    Text("Perceived lightness value is \(perceivedLightness)")
                        .foregroundColor(theme.current.text)
                        .font(.heavy(ofSize: 16))
                    Spacer()
                }
            }
        }
    }

    private var settingsView: some View {
        VStack {
            HStack {
                Text("Settings")
                    .foregroundColor(theme.current.text)
                    .font(.heavy(ofSize: 16))
                Spacer()
            }

            Toggle(isOn: $showText) {
                Text("Show sample text")
                    .foregroundColor(theme.current.text)
                    .font(.regular(ofSize: 16))
            }.tint(theme.current.primary)

            HStack {
                Text("Text color")
                    .foregroundColor(theme.current.text)
                    .font(.regular(ofSize: 16))
                Spacer()
                Picker("Text color", selection: $textColor) {
                    Text("Auto").tag(TextColor.auto)
                    Text("White").tag(TextColor.light)
                    Text("Black").tag(TextColor.dark)
                }
                .pickerStyle(.menu)
                .tint(theme.current.primary)
            }

            HStack {
                Text("Algorithm to use")
                    .foregroundColor(theme.current.text)
                    .font(.regular(ofSize: 16))
                Spacer()
                Picker("Algorithm", selection: $algorithm) {
                    Text("Simple").tag(LuminanceAlgorithm.simple)
                    Text("Complex").tag(LuminanceAlgorithm.complex)
                }
                .pickerStyle(.menu)
                .tint(theme.current.primary)
            }
        }
    }

    private func getSampleTextColor() -> Color {
        switch textColor {
        case .auto:
            return .red
        case .light:
            return .white
        case .dark:
            return .black
        }
    }
}

struct LuminanceView_Previews: PreviewProvider {
    static var previews: some View {
        LuminanceView()
            .environmentObject(ThemeManager())
    }
}
