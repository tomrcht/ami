//
//  PurpleTheme.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import SwiftUI

struct PurpleTheme: Theme {
    let id = "purple-theme"

    /// #d398ff
    let primary = Color(red: 211 / 255, green: 152 / 255, blue: 255 / 255)
    /// #ffaaa6
    let secondary = Color(red: 255 / 170, green: 166 / 255, blue: 166 / 255)

    /// #80ffb0
    let success = Color(red: 128 / 255, green: 255 / 255, blue: 176 / 255)
    /// #ffdda3
    let warning = Color(red: 255 / 255, green: 221 / 255, blue: 163 / 255)
    /// ffaaa6
    var error: Color { secondary }

    /// #020630
    let text = Color(red: 2 / 255, green: 6 / 255, blue: 48 / 255)
    /// #f0f0f0
    let background = Color(red: 240 / 255, green: 240 / 255, blue: 255 / 255)

}
