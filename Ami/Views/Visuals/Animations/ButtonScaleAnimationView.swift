//
//  ButtonScaleAnimationView.swift
//  Ami
//
//  Created by Tom Rochat on 05/01/2023.
//

import SwiftUI

struct ButtonScaleAnimationView: View {
    @State private var tapped = false

    var body: some View {
        RoundIconButton(
            tapped: $tapped,
            iconName: "heart.fill",
            size: 100,
            color: .purple
        )
        .onTapGesture {
            tapped.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tapped.toggle()
            }
        }
    }
}

private struct RoundIconButton: View {
    @Binding private var tapped: Bool
    @Environment(\.colorScheme) var colorScheme
    private let iconName: String
    private let size: CGFloat
    private let color: Color

    init(tapped: Binding<Bool>, iconName: String, size: CGFloat, color: Color) {
        self._tapped = tapped
        self.iconName = iconName
        self.size = size
        self.color = color
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: size + 4, height: size + 4)
                .scaleEffect(tapped ? 1.2 : 1)
                .animation(.easeInOut(duration: 0.1), value: tapped)

            Circle()
                .fill(colorScheme == .light ? .white : .black)
                .frame(width: size, height: size)
                .scaleEffect(tapped ? 1.2 : 1)
                .animation(.easeInOut(duration: 0.1), value: tapped)

            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color)
                .frame(width: size / 2, height: size / 2)
                .scaleEffect(tapped ? 1.2 : 1)
                .animation(.easeInOut(duration: 0.1), value: tapped)
        }
    }
}

struct ButtonScaleAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonScaleAnimationView()
    }
}
