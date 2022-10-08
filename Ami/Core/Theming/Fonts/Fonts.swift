//
//  Fonts.swift
//  Ami
//
//  Created by Tom Rochat on 08/10/2022.
//

import SwiftUI

// Avenir-Heavy
// Avenir-Oblique
// Avenir-Black
// Avenir-Book
// Avenir-BlackOblique
// Avenir-HeavyOblique
// Avenir-Light
// Avenir-MediumOblique
// Avenir-Medium
// Avenir-LightOblique
// Avenir-Roman
// Avenir-BookOblique
extension Font {
    static func title(ofSize size: CGFloat) -> Font {
        .custom("Avenir", size: size)
    }

    static func regular(ofSize size: CGFloat) -> Font {
        .custom("Avenir-Roman", size: size)
    }

    static func heavy(ofSize size: CGFloat) -> Font {
        .custom("Avenir-Heavy", size: size)
    }

    static func light(ofSize size: CGFloat) -> Font {
        .custom("Avenir-Light", size: size)
    }
}
