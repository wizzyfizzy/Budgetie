//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import AuthAPI

struct AuthResponse: Codable {
    let message: String
    let user: RUserData
    let token: String
}

enum AuthAPIError: Error {
    case invalidCredentials
    case userExists
    case userNotFound
    case missingFields
    case unknown
}

protocol AuthAPISource {
    func signup(name: String, email: String, password: String) async throws -> UserData
    func login(email: String, password: String) async throws -> UserData
    func forgotPassword(email: String) async throws -> String
}

final class AuthAPISourceImpl: AuthAPISource {
    private let baseURL = "http://127.0.0.1:8000/auth"
    // 🔥 change it to Macs's IP when run on device
    //    private let baseURL = "http://192.168.1.42:5000/auth"

    func signup(name: String, email: String, password: String) async throws -> UserData {
        let response = try await request(path: "/signup", body: ["name": name, "email": email, "password": password])
        return UserData(id: response.user.id, email: response.user.email, name: response.user.name, token: response.token)
    }

    func login(email: String, password: String) async throws -> UserData {
        let response = try await request(path: "/login", body: ["email": email, "password": password])
        return UserData(id: response.user.id, email: response.user.email, name: response.user.name, token: response.token)
    }

    func forgotPassword(email: String) async throws -> String {
        try await request(path: "/forgot-password", body: ["email": email]).message
    }

    // MARK: - Private helper
    private func request(path: String, body: [String: Any]) async throws -> AuthResponse {
        guard let url = URL(string: "\(baseURL)\(path)") else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        // decode json first to see if error exists
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
            let errorResp = try JSONDecoder().decode([String: String].self, from: data)
            switch errorResp["error"] {
            case "InvalidCredentials": throw AuthAPIError.invalidCredentials
            case "UserExists": throw AuthAPIError.userExists
            case "UserNotFound": throw AuthAPIError.userNotFound
            case "MissingFields": throw AuthAPIError.missingFields
            default: throw AuthAPIError.unknown
            }
        }

        let result = try JSONDecoder().decode(AuthResponse.self, from: data)
        return result
    }
}
