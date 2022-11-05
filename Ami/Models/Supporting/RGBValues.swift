//
//  RGBValues.swift
//  Ami
//
//  Created by Tom Rochat on 05/11/2022.
//

import SwiftUI

struct RGBValues: Equatable {
    var red: Double
    var green: Double
    var blue: Double

    var color: Color {
        Color(red: red / 255, green: green / 255, blue: blue / 255)
    }
}
