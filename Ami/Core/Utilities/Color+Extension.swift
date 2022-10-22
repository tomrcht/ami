//
//  Color+Extension.swift
//  Ami
//
//  Created by Tom Rochat on 21/10/2022.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1),
            opacity: 1
        )
    }
}
