//
//  AnimationsView.swift
//  Ami
//
//  Created by Tom Rochat on 05/01/2023.
//

import SwiftUI

struct AnimationsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TwitterLikeView()
                ButtonScaleAnimationView()
            }
        }
    }
}

struct AnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsView()
    }
}
