//
//  InjectionKey.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import Foundation

protocol InjectionKey {
    associatedtype Value

    static var value: Value { get set }
}
