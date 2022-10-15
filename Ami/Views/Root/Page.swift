//
//  Page.swift
//  Ami
//
//  Created by Tom Rochat on 15/10/2022.
//

enum Page: Identifiable, Hashable {
    typealias ID = String

    case home
    case settings

    static let all: [Page] = [
        .home,
        .settings,
    ]

    var id: ID {
        switch self {
        case .home:
            return "home"
        case .settings:
            return "settings"
        }
    }

    var name: String {
        switch self {
        case .home:
            return "Home"
        case .settings:
            return "Settings"
        }
    }

    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .settings:
            return "gear"
        }
    }
}
