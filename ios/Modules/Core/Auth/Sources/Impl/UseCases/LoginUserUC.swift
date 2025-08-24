//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI

// sourcery: AutoMockable
/// Handles logging in a user.
protocol LoginUserUC {
    /// Performs login with email and password.
    /// - Parameters:
    ///   - email: User email.
    ///   - password: User password.
    /// - Returns: Logged-in user data.
    /// - Throws: Errors if credentials are invalid or network fails.
    func execute(email: String, password: String) async throws -> UserData
}

class LoginUserUCImpl: LoginUserUC {
    @Injected private var repo: AuthAPIRepo

    func execute(email: String, password: String) async throws -> UserData {
        try await repo.login(email: email, password: password)
    }
}
