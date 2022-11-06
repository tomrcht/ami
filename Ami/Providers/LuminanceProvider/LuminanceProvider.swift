//
//  LuminanceProvider.swift
//  Ami
//
//  Created by Tom Rochat on 05/11/2022.
//

import Foundation

protocol LuminanceProviding {
    func simple(red: Double, green: Double, blue: Double) -> Double
    func complex(red: Double, green: Double, blue: Double) -> Double
    func perceivedLightness(luminance: Double) -> Double
}

struct LuminanceProvider: LuminanceProviding {
    /// Calculates the luminance for a given sRGB color. This method does *not* linearizes the sRGB component,
    /// therefore the results might not be the best. Use the `complex` method if a more precise value is required.
    ///
    /// The resulting value, while not the most correct, takes into account the fact that the human eye is more
    /// sensible to green light and less to red and blue light
    ///
    /// **Sources**
    /// - [Relative luminance Wikipedia page](https://en.wikipedia.org/wiki/Relative_luminance)
    /// - [WCAG 2.1](https://www.w3.org/TR/2018/REC-WCAG21-20180605/)
    ///
    /// - parameters:
    ///     - red: The red component of the color, must be in range 0...1
    ///     - green: The green component of the color, must be in range 0...1
    ///     - blue: The blue component of the color, must be in range 0...1
    /// - returns: A computed value for the luminance based on the given sRGB colors
    func simple(red: Double, green: Double, blue: Double) -> Double {
        assert((0...1).contains(red), "Red component is out of acceptable range")
        assert((0...1).contains(green), "Green component is out of acceptable range")
        assert((0...1).contains(blue), "Blue component is out of acceptable range")

        return 0.2126 * red + 0.7152 * green + 0.0722 * blue
    }

    /// Calculates the luminance for a given sRGB color. Unlinke the `simple` method, this solution takes into account
    /// the fact that sRGB values *needs* to be linearized
    ///
    /// All values are pulled from the [sRGB Wikipedia page](https://en.wikipedia.org/wiki/SRGB)
    ///
    /// - parameters:
    ///     - red: The red component of the color, must be in range 0...255
    ///     - green: The green component of the color, must be in range 0...255
    ///     - blue: The blue component of the color, must be in range 0...255
    /// - returns: A computed value for the luminance based on the given sRGB colors
    func complex(red: Double, green: Double, blue: Double) -> Double {
        assert((0...1).contains(red), "Red component is out of acceptable range")
        assert((0...1).contains(green), "Green component is out of acceptable range")
        assert((0...1).contains(blue), "Blue component is out of acceptable range")

        let linearRed = linearizeToCIEXYZ(sRGB: red)
        let linearGreen = linearizeToCIEXYZ(sRGB: green)
        let linearBlue = linearizeToCIEXYZ(sRGB: blue)

        return 0.2126 * linearRed + 0.7152 * linearGreen + 0.0722 * linearBlue
    }

    /// Caculates the perceived lightness based on the luminance of a given color
    func perceivedLightness(luminance: Double) -> Double {
        assert((0...1).contains(luminance), "Luminance is out of acceptable range")

        if luminance <= 0.008856 {
            return luminance * 903.3
        } else {
            return pow(luminance, 1 / 3) * 116 - 16
        }
    }

    /// Linearizes an sRGB value to the CIE XYZ color space
    private func linearizeToCIEXYZ(sRGB value: Double) -> Double {
        assert((0...1).contains(value), "Value is out of acceptable range")

        if value < 0.04045 {
            return value / 12.92
        } else {
            return pow((value + 0.055) / 1.055, 2.4)
        }
    }
}

#if DEBUG
struct LuminanceProviderMock: LuminanceProviding {
    func simple(red: Double, green: Double, blue: Double) -> Double { 0.0 }
    func complex(red: Double, green: Double, blue: Double) -> Double { 0.0 }
    func perceivedLightness(luminance: Double) -> Double { 0.0 }
}
#endif
