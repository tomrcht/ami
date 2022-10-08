//
//  HelloProvider.swift
//  Ami
//
//  Created by Tom Rochat on 07/10/2022.
//

import Foundation

protocol HelloProviding {
    func sayHello()
}

struct HelloProvider: HelloProviding {
    func sayHello() {
        print("Hello, friend")
    }
}

// Mock, should be elsewhere but...
#if DEBUG
struct MockHelloProvider: HelloProviding {
    func sayHello() {
        print("Hello, mocked friend")
    }
}
#endif
