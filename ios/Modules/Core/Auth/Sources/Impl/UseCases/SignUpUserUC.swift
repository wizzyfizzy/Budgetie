//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI

// sourcery: AutoMockable
/// Handles user sign-up.
protocol SignUpUserUC {
    /// Performs sign-up with user info.
    /// - Parameters:
    ///   - name: User name.
    ///   - email: User email.
    ///   - password: User password.
    /// - Returns: Created user data.
    /// - Throws: Errors if sign-up fails.
    func execute(name: String, email: String, password: String) async throws -> UserData
}

class SignUpUserUCImpl: SignUpUserUC {
    @Injected private var repo: AuthAPIRepo

    func execute(name: String, email: String, password: String) async throws -> UserData {
        try await repo.signup(name: name, email: email, password: password)
    }
}
