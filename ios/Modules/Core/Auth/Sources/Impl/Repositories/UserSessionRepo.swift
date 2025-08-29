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
    func logoutUser()
}

final class UserSessionRepoImpl: UserSessionRepo {
    @Injected private var localSource: UserSessionSource
    private lazy var userSubject: CurrentValueSubject<UserData?, Never> = {
        let currentUser = localSource.loadUser()
        return CurrentValueSubject<UserData?, Never>(currentUser)
    }()
    
    func saveUser(_ user: UserData) throws {
        try localSource.save(user: user)
        userSubject.send(user)
    }
    
    func getUser() -> UserData? {
        userSubject.value
    }
    
    func getUserPublisher() -> AnyPublisher<UserData?, Never> {
        userSubject.eraseToAnyPublisher()
    }
    
    func logoutUser() {
        localSource.clear()
        userSubject.send(nil)
    }
}
