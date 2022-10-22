//
//  Theme.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import SwiftUI

protocol Theme: Identifiable where ID == String {
    var primary: Color { get }
    var secondary: Color { get }

    var success: Color { get }
    var warning: Color { get }
    var error: Color { get }

    var text: Color { get }
    var background: Color { get }
}
