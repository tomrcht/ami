//
//  TwitterLikeView.swift
//  Ami
//
//  Created by Tom Rochat on 05/01/2023.
//

import SwiftUI

struct TwitterLikeView: View {
    @State private var liked = false


    @State private var showFilledHeart = false
    @State private var filledHeartScale: CGFloat = 0.2

    @State private var showAnimationRings = false
    @State private var outerRingScale: CGFloat = 0.2
    @State private var outerRingColor = Color.red
    @State private var innerRingScale: CGFloat = 0.1

    @Environment(\.colorScheme) var colorScheme

    private let size: CGFloat = 100

    private var buttonOpacity: CGFloat {
        if showFilledHeart { return 1 }
        return liked ? 0 : 1
    }
    private var defaultButtonColor: Color {
        colorScheme == .light ? .black : .white
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(outerRingColor)
                .scaleEffect(outerRingScale)
                .frame(width: size, height: size)
                .opacity(showAnimationRings ? 1 : 0)

            Circle()
                .fill(colorScheme == .light ? .white : .black)
                .scaleEffect(innerRingScale)
                .frame(width: size, height: size)
                .opacity(showAnimationRings ? 1 : 0)

            Button {
                liked ? unlike() : like()
            } label: {
                Image(systemName: liked ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(showFilledHeart ? .red : defaultButtonColor)
                    .frame(width: size, height: size)
                    .scaleEffect(liked ? filledHeartScale : 1)
            }
            .buttonStyle(.plain)
            .opacity(buttonOpacity)
        }
    }

    private func like() {
        liked.toggle()
        showAnimationRings.toggle()

        withAnimation(.easeInOut(duration: 0.2)) {
            outerRingScale = 1.2
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.2)) {
                outerRingColor = .purple
                innerRingScale = 1.2
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.1)) {
                showAnimationRings.toggle()
                showFilledHeart.toggle()
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.1)) {
                filledHeartScale = 1
            }
        }
    }

    private func unlike() {
        liked = false
        showFilledHeart = false
        filledHeartScale = 0.2
        showAnimationRings = false
        outerRingScale = 0.2
        outerRingColor = .red
        innerRingScale = 0.1
    }
}

struct TwitterLikeView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterLikeView()
    }
}
