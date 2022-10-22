//
//  Themes.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

enum Themes {
    case `default`
    case purple

    var value: any Theme {
        switch self {
        case .default: return PurpleTheme()

        case .purple: return PurpleTheme()
        }
    }
}
