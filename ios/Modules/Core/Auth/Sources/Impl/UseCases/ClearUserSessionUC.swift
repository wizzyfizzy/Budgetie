//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import UIComponents

// sourcery: AutoMockable
protocol ClearUserSessionUC {
    func execute()
}

class ClearUserSessionUCImpl: ClearUserSessionUC {
    @Injected private var repo: UserSessionRepo
    private let appState = AppState.shared

    func execute() {
        repo.clearUser()
        appState.userID = nil
    }
}
