//
//  HelloProviderInjection.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import Foundation

private struct HelloProviderInjectionKey: InjectionKey {
    static var value: any HelloProviding = HelloProvider()
}

extension InjectionResolver {
    var helloProvider: any HelloProviding {
        get { Self[HelloProviderInjectionKey.self] }
        set { Self[HelloProviderInjectionKey.self] = newValue }
    }
}
