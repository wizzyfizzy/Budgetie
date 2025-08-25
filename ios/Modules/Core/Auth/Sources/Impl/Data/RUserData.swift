//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

// Remote UserData retrieved from API
struct RUserData: Codable, Equatable {
    public let id: String
    public let email: String
    public let name: String

    public init(id: String, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }
}

struct RAuthResponse: Codable {
    let message: String
    let user: RUserData
    let token: String
}

struct RAuthResponseForgotPassword: Codable {
    let message: String
}
