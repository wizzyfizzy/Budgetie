//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI

// sourcery: AutoMockable
protocol LoginUserUC {
    func execute(email: String, password: String) async throws -> UserData
}

class LoginUserUCImpl: LoginUserUC {
    @Injected private var repo: AuthAPIRepo

    func execute(email: String, password: String) async throws -> UserData {
        try await repo.login(email: email, password: password)
    }
}
