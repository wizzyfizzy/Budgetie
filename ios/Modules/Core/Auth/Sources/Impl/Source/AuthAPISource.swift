//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import AuthAPI
import BTRestClientAPI

// sourcery: AutoMockable
/// Abstracts direct network calls for authentication API.
protocol AuthAPISource {
    /// Signs up a user via network.
    func signup(name: String, email: String, password: String) async throws -> UserData
    /// Logs in a user via network.
    func login(email: String, password: String) async throws -> UserData
    /// Sends a forgot-password request via network.
    func forgotPassword(email: String) async throws -> String
}

final class AuthAPISourceImpl: AuthAPISource {
    @Injected private var client: HTTPClient
    
    func signup(name: String, email: String, password: String) async throws -> UserData {
        let response: RAuthResponse = try await client.request(
            path: .signup,
            method: .post,
            body: ["name": name, "email": email, "password": password],
            headers: nil,
            errorMapping: HTTPError.self
        )
        return response.mapToDomain()
    }

    func login(email: String, password: String) async throws -> UserData {
        let response: RAuthResponse = try await client.request(
            path: .login,
            method: .post,
            body: ["email": email, "password": password],
            headers: nil,
            errorMapping: HTTPError.self
        )
        return response.mapToDomain()
    }

    func forgotPassword(email: String) async throws -> String {
        let response: RAuthResponseForgotPassword = try await client.request(
            path: .forgotPassword,
            method: .post,
            body: ["email": email],
            headers: nil,
            errorMapping: HTTPError.self
        )
        return response.mapToDomain().message
    }
}

extension RAuthResponse {
    func mapToDomain() -> UserData {
        UserData(id: user.id, email: user.email, name: user.name, token: token)
    }
}

extension RAuthResponseForgotPassword {
    func mapToDomain() -> DAuthResponseForgotPassword {
        DAuthResponseForgotPassword(message: message)
    }
}
