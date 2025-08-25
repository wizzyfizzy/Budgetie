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
/// Abstracts storage of user session locally (UserDefaults/Keychain).
protocol UserSessionSource {
    /// Saves user data.
    func save(user: UserData) throws
    /// Loads the saved user data, if any.
    func loadUser() -> UserData?
    /// Clears stored user data.
    func clear()
}

final class UserSessionSourceImpl: UserSessionSource {
    private let userDefaults: UserDefaults
    private let store: SecureStore
    
    init(store: SecureStore = KeychainSecureStore(),
         userDefaults: UserDefaults = UserDefaults.standard) {
        self.store = store
        self.userDefaults = userDefaults
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
