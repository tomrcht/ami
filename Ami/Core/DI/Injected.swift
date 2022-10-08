//
//  Injected.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectionResolver, T>

    var wrappedValue: T {
        get { InjectionResolver[keyPath] }
        set { InjectionResolver[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<InjectionResolver, T>) {
        self.keyPath = keyPath
    }
}
