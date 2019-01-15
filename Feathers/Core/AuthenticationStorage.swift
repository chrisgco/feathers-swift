//
//  AuthenticationStorage.swift
//  Feathers
//
//  Created by Brendan Conron on 5/3/17.
//  Copyright © 2017 FeathersJS. All rights reserved.
//

import Foundation
import KeychainSwift

/// Authentication storage protocol.
public protocol AuthenticationStorage: class {

    init(storageKey: String)
    var accessToken: String? { get set }

}

/// An encrypted authentication store. Uses the keychain to store a token.
public final class EncryptedAuthenticationStore: AuthenticationStorage {

    private let keychain = KeychainSwift()
    private let storageKey: String

    public var accessToken: String? {
        get { return keychain.get(storageKey) }
        set {
            if let value = newValue {
                keychain.set(value, forKey: storageKey)
            } else {
                keychain.delete(storageKey)
            }
        }
    }

    public init(storageKey: String = "feathers-jwt") {
        self.storageKey = storageKey
    }

}
