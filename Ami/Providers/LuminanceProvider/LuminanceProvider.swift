//
//  LuminanceProvider.swift
//  Ami
//
//  Created by Tom Rochat on 05/11/2022.
//

import Foundation

protocol LuminanceProviding {
    func simple(red: Double, green: Double, blue: Double) -> Double
}

struct LuminanceProvider: LuminanceProviding {
    /// Calculates the luminance for a given sRGB color. This method does *not* linearizes the sRGB component,
    /// therefore the results might not be the best. Use the `complex` method if a more precise value is required.
    ///
    /// The resulting value, while not the most correct, takes into account the fact that the human eye is more
    /// sensible to green light and less to red and blue light
    ///
    /// Source : [Relative luminance Wikipedia page](https://en.wikipedia.org/wiki/Relative_luminance)
    ///
    /// - parameters:
    ///     - red: The red component of the color, must be in range 0...255
    ///     - green: The green component of the color, must be in range 0...255
    ///     - blue: The blue component of the color, must be in range 0...255
    /// - returns: A computed value for the luminance based on the given sRGB colors
    func simple(red: Double, green: Double, blue: Double) -> Double {
        assert((0...255).contains(red), "Red component is out of acceptable range")
        assert((0...255).contains(green), "Green component is out of acceptable range")
        assert((0...255).contains(blue), "Blue component is out of acceptable range")

        return 0.2126 * red + 0.7152 * green + 0.0722 * blue
    }
}

#if DEBUG
struct LuminanceProviderMock: LuminanceProviding {
    func simple(red: Double, green: Double, blue: Double) -> Double {
        0.0
    }
}
#endif
