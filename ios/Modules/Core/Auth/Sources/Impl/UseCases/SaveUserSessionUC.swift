//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI
import UIComponents

// sourcery: AutoMockable
/// Saves the logged-in user session.
protocol SaveUserSessionUC {
    /// Saves the given user session.
    /// - Parameters:
    ///   - user: User data to save.
    /// - Throws: Errors if saving fails.
    func execute(user: UserData) throws
}

class SaveUserSessionUCImpl: SaveUserSessionUC {
    @Injected private var repo: UserSessionRepo

    func execute(user: UserData) throws {
        try repo.saveUser(user)
    }
}
