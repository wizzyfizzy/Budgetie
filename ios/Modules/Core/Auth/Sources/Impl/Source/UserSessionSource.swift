//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import AuthAPI
import UIComponents

// sourcery: AutoMockable
protocol UserSessionSource {
    func save(user: UserData) throws
    func loadUser() -> UserData?
    func clear()
}

final class UserSessionSourceImpl: UserSessionSource {
    private let userDefaults = UserDefaults.standard
    private let accountKey = "loggedInUser"
    private let store: SecureStore
    
    init(store: SecureStore = KeychainSecureStore()) {
        self.store = store
    }

    func save(user: UserData) throws {
        // Save to Keychain
        try store.save(user, key: KeychainKeys.loggedInUser)
        userDefaults.isUserLoggedIn = true
    }
    
    func loadUser() -> UserData? {
        guard userDefaults.isUserLoggedIn else { return nil }
        return store.load(KeychainKeys.loggedInUser, as: UserData.self)
    }
    
    func clear() {
        userDefaults.isUserLoggedIn = false
        // Delete from Keychain
        store.delete(KeychainKeys.loggedInUser)
    }
}
