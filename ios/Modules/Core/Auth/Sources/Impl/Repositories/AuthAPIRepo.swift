//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import AuthAPI

// sourcery: AutoMockable
protocol AuthAPIRepo {
    func login(email: String, password: String) async throws -> UserData
    func signup(name: String, email: String, password: String) async throws -> UserData
    func forgotPassword(email: String) async throws -> String
}

final class AuthAPIRepoImpl: AuthAPIRepo {
    @Injected private var source: AuthAPISource
    
      func login(email: String, password: String) async throws -> UserData {
          try await source.login(email: email, password: password)
      }

      func signup(name: String, email: String, password: String) async throws -> UserData {
          try await source.signup(name: name, email: email, password: password)
      }

      func forgotPassword(email: String) async throws -> String {
          try await source.forgotPassword(email: email)
      }
}
