//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import UIComponents

// sourcery: AutoMockable
/// Handles the "Forgot Password" feature.
protocol ForgotPasswordUC {
    /// Sends a reset password email.
    /// - Parameters:
    ///   - email: User's email.
    /// - Returns: A success message string.
    /// - Throws: Errors if the email is invalid or the network call fails.
    func execute(email: String) async throws -> String
}

class ForgotPasswordUCImpl: ForgotPasswordUC {
    @Injected private var repo: AuthAPIRepo

    func execute(email: String) async throws -> String {
        try await repo.forgotPassword(email: email)
    }
}
