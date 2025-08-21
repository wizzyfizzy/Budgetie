//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI
import UIComponents

// sourcery: AutoMockable
protocol SaveUserSessionUC {
    func execute(user: UserData) throws
}

class SaveUserSessionUCImpl: SaveUserSessionUC {
    @Injected private var repo: UserSessionRepo
    private let appState = AppState.shared

    func execute(user: UserData) throws {
        try repo.saveUser(user)
        appState.userID = user.id
    }
}
