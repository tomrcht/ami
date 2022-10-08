//
//  Themes.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

enum Themes {
    case purple
    case red
    case green

    var value: any Theme {
        switch self {
        case .purple: return PurpleTheme()
        case .red: return RedTheme()
        case .green: return GreenTheme()
        }
    }
}
