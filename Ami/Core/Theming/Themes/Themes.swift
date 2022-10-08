//
//  Themes.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

enum Themes: Identifiable {
    case purple
    case red
    case green

    var id: String {
        switch self {
        case .purple: return PurpleTheme.id
        case .red: return RedTheme.id
        case .green: return GreenTheme.id
        }
    }

    var value: any Theme {
        switch self {
        case .purple: return PurpleTheme()
        case .red: return RedTheme()
        case .green: return GreenTheme()
        }
    }
}
