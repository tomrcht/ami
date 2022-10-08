//
//  InjectionResolver.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import Foundation

struct InjectionResolver {
    private static var instance = Self()

    static subscript<T>(_ keyPath: WritableKeyPath<Self, T>) -> T {
        get { instance[keyPath: keyPath] }
        set { instance[keyPath: keyPath] = newValue }
    }

    static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.value }
        set { key.value = newValue }
    }
}
