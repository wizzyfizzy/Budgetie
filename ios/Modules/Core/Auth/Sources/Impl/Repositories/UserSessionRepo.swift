//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI

// sourcery: AutoMockable
protocol UserSessionRepo {
    func saveUser(_ user: UserData) throws
    func getUser() -> UserData?
    func clearUser()
}

final class UserSessionRepoImpl: UserSessionRepo {
    @Injected private var localSource: UserSessionSource
    
    func saveUser(_ user: UserData) throws {
        try localSource.save(user: user)
    }
    
    func getUser() -> UserData? {
        localSource.loadUser()
    }
    
    func clearUser() {
        localSource.clear()
    }
}
