//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI

// sourcery: AutoMockable
protocol SignUpUserUC {
    func execute(name: String, email: String, password: String) async throws -> UserData
}

class SignUpUserUCImpl: SignUpUserUC {
    @Injected private var repo: AuthAPIRepo

    func execute(name: String, email: String, password: String) async throws -> UserData {
        try await repo.signup(name: name, email: email, password: password)
    }
}
