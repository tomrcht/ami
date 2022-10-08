//
//  ThemeManager.swift
//  Ami
//
//  Created by Tom Rochat on 06/10/2022.
//

import Foundation

final class ThemeManager: ObservableObject {
    @Published private(set) var current: any Theme

    init(defaultTheme: any Theme) {
        self.current = defaultTheme
    }

    /// Updates the current theme to the new one, if both are different
    ///
    /// - Parameters:
    ///     - theme: The new theme to use
    /// - Returns: `true` if the theme was changed, `false` otherwise
    @discardableResult
    func changeTheme(to theme: Themes) -> Bool {
        let newTheme = theme.value
        guard newTheme.id != current.id else {
            return false
        }

        self.current = newTheme
        return true
    }
}
