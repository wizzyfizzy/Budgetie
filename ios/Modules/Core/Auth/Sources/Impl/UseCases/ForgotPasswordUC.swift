//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import UIComponents

// sourcery: AutoMockable
protocol ForgotPasswordUC {
    func execute(email: String) async throws -> String
}

class ForgotPasswordUCImpl: ForgotPasswordUC {
    @Injected private var repo: AuthAPIRepo

    func execute(email: String) async throws -> String {
        try await repo.forgotPassword(email: email)
    }
}

