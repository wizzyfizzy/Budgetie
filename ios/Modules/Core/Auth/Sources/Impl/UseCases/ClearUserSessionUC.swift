//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import UIComponents

// sourcery: AutoMockable
/// Handles clearing the current user session.
protocol ClearUserSessionUC {
    /// Clears the current user session.
    func execute()
}

class ClearUserSessionUCImpl: ClearUserSessionUC {
    @Injected private var repo: UserSessionRepo

    func execute() {
        repo.clearUser()
    }
}
