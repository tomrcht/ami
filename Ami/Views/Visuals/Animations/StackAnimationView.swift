//
//  StackAnimationView.swift
//  Ami
//
//  Created by Tom Rochat on 17/01/2023.
//

import SwiftUI

struct StackAnimationView: View {
    @State private var animated = false

    @State private var hue: Double = 0.5
    @State private var speed: Double = 1
    @State private var delay: Double = 0.1

    @State private var response: Double = 0.5
    @State private var dampingFraction: Double = 0.8
    @State private var blendDuration: Double = 0.1

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 8) {
                ZStack {
                    ForEach(0..<10) { index in
                        let delta = Double(index) * 0.1
                        let fillColor = Color(hue: hue, saturation: 1 - delta, brightness: delta)
                        let shadowColor = Color(hue: hue, saturation: 0.5, brightness: delta)

                        Rectangle()
                            .fill(fillColor)
                            .cornerRadius(animated ? proxy.size.width * 0.1 : proxy.size.width)
                            .aspectRatio(1, contentMode: .fit)
                            .scaleEffect(1 - CGFloat(index) * 0.1, anchor: .center)
                            .rotationEffect(
                                animated ? Angle.degrees(Double(index) * 10) : Angle.degrees(0),
                                anchor: .center
                            )
                            .shadow(color: shadowColor, radius: 5)
                            .animation(animation(index), value: animated)
                    }
                }
                .padding(24)
                .onTapGesture {
                    withAnimation { animated.toggle() }
                }

                ScrollView {
                    VStack(spacing: 8) {
                        HStack {
                            Text("Hue").font(.heavy(ofSize: 14))
                            Slider(value: $hue, in: 0...1)
                                .padding(8)
                            Text("(\(String(format: "%.2f", hue)))").font(.heavy(ofSize: 8))
                        }

                        HStack {
                            Text("Speed").font(.heavy(ofSize: 14))
                            Slider(value: $speed, in: 0...2, step: 0.05)
                                .padding(8)
                            Text("(\(String(format: "%.2f", speed)))").font(.heavy(ofSize: 8))
                        }

                        HStack {
                            Text("Delay").font(.heavy(ofSize: 14))
                            Slider(value: $delay, in: 0...1, step: 0.05)
                                .padding(8)
                            Text("(\(String(format: "%.2f", delay)))").font(.heavy(ofSize: 8))
                        }

                        Text("Spring parameters")
                            .font(.heavy(ofSize: 16))

                        HStack {
                            Text("Response").font(.heavy(ofSize: 14))
                            Slider(value: $response, in: 0...1)
                                .padding(8)
                            Text("(\(String(format: "%.2f", response)))").font(.heavy(ofSize: 8))
                        }
                        HStack {
                            Text("Damping").font(.heavy(ofSize: 14))
                            Slider(value: $dampingFraction, in: 0...1)
                                .padding(8)
                            Text("(\(String(format: "%.2f", dampingFraction)))").font(.heavy(ofSize: 8))
                        }
                        HStack {
                            Text("Blend duration").font(.heavy(ofSize: 14))
                            Slider(value: $blendDuration, in: 0...1)
                                .padding(8)
                            Text("(\(String(format: "%.2f", blendDuration)))").font(.heavy(ofSize: 8))
                        }
                    }
                }
            }
        }
    }

    private func animation(_ index: Int) -> Animation {
        Animation
            .spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration)
            .speed(speed)
            .delay(Double(index) * delay)
    }
}

struct StackAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        StackAnimationView()
            .padding()
    }
}
