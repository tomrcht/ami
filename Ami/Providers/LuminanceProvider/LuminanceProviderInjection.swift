//
//  LuminanceProviderInjection.swift
//  Ami
//
//  Created by Tom Rochat on 05/11/2022.
//

import Foundation

private struct LuminanceProviderInjectionKey: InjectionKey {
    static var value: any LuminanceProviding = LuminanceProvider()
}

extension InjectionResolver {
    var luminanceProvider: any LuminanceProviding {
        get { Self[LuminanceProviderInjectionKey.self] }
        set { Self[LuminanceProviderInjectionKey.self] = newValue }
    }
}
