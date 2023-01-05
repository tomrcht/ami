//
//  TwitterLikeView.swift
//  Ami
//
//  Created by Tom Rochat on 05/01/2023.
//

import SwiftUI

struct TwitterLikeView: View {
    @State private var liked = false

    @State private var showRedHeart = false
    @State private var redHeartScale: CGFloat = 0.2

    @State private var showCircularRings = false
    @State private var circularRingScaleRate: CGFloat = 0.2
    @State private var circularRingColor = Color.red
    @State private var whiteCircularRingScaleRate: CGFloat = 0.1

    @Environment(\.colorScheme) var colorScheme

    private let size: CGFloat = 24

    private var buttonOpacity: CGFloat {
        if showRedHeart { return 1 }
        return liked ? 0 : 1
    }
    private var defaultButtonColor: Color {
        colorScheme == .light ? .black : .white
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(circularRingColor)
                .scaleEffect(circularRingScaleRate)
                .frame(width: size, height: size)
                .opacity(showCircularRings ? 1 : 0)

            Circle()
                .fill(colorScheme == .light ? .white : .black)
                .scaleEffect(whiteCircularRingScaleRate)
                .frame(width: size, height: size)
                .opacity(showCircularRings ? 1 : 0)

            Button {
                liked ? unlike() : like()
            } label: {
                Image(systemName: liked ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(showRedHeart ? .red : defaultButtonColor)
                    .frame(width: size, height: size)
                    .scaleEffect(liked ? redHeartScale : 1)
            }
            .buttonStyle(.plain)
            .opacity(buttonOpacity)
        }
    }

    private func like() {
        withAnimation(.easeInOut(duration: 0.01)) {
            liked.toggle()
            showCircularRings.toggle()
        }
        withAnimation(.easeInOut(duration: 0.2)) {
            circularRingScaleRate = 1.2
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.2)) {
                circularRingColor = .purple
                whiteCircularRingScaleRate = 1.2
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.1)) {
                showCircularRings.toggle()
                showRedHeart.toggle()
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.1)) {
                redHeartScale = 1
            }
        }
    }

    private func unlike() {
        liked = false
        showRedHeart = false
        redHeartScale = 0.2
        showCircularRings = false
        circularRingScaleRate = 0.2
        circularRingColor = .red
        whiteCircularRingScaleRate = 0.1
    }
}

struct TwitterLikeView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterLikeView()
    }
}
