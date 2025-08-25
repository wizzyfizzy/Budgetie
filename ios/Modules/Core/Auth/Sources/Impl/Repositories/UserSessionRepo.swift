//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI
import Combine
import Foundation

// sourcery: AutoMockable
/// Handles local user session storage.
protocol UserSessionRepo {
    /// Saves the user session.
    func saveUser(_ user: UserData) throws
    /// Returns the current user session, if any.
    func getUser() -> UserData?
    /// Returns a publisher that emits the current user data whenever it changes.
    func getUserPublisher() -> AnyPublisher<UserData?, Never>
    /// Clears the current user session.
    func clearUser()
}

final class UserSessionRepoImpl: UserSessionRepo {
    @Injected private var localSource: UserSessionSource
    private let userSubject = CurrentValueSubject<UserData?, Never>(nil)

    func saveUser(_ user: UserData) throws {
        try localSource.save(user: user)
        userSubject.send(user)
    }
    
    func getUser() -> UserData? {
        localSource.loadUser()
    }
    
    func getUserPublisher() -> AnyPublisher<UserData?, Never> {
        userSubject.send(localSource.loadUser())
        return userSubject.eraseToAnyPublisher()
    }
    
    func clearUser() {
        localSource.clear()
        userSubject.send(nil)
    }
}
