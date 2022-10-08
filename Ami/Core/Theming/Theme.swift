//
//  Theme.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import SwiftUI

protocol Theme: Identifiable where ID == String {
    var mainColor: Color { get }
}
