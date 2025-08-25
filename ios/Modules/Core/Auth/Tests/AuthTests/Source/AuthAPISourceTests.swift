//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import XCTest
@testable import Auth
import AuthAPI
import UIComponents
import BTRestClientAPI
import BTRestClientMocks
import DIModule

final class AuthAPISourceTests: XCTestCase {
    private func arrange() -> (source: AuthAPISource,
                               restClient: BTRestClientMocks) {
        
        let restClient = BTRestClientMocks()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(HTTPClient.self) { _ in restClient }
        
        return (AuthAPISourceImpl(), restClient)
    }
    
    private let user = UserData(id: "123", email: "test@test.gr", name: "Kris", token: "123")
    private let rUser = RUserData(id: "123", email: "test@test.gr", name: "Kris")

    func testLogin() async throws {
        let (source, restClient) = arrange()
        let expectedMessage = "Reset email sent"
        let token = "123"

        restClient.stub = { path, method, body, headers in
            XCTAssertEqual(path, .login)
            XCTAssertEqual(method, .post)
            return RAuthResponse(message: expectedMessage,
                                 user: self.rUser,
                                 token: token)
        }

        // Act
        let receivedUser = try await source.login( email: user.email, password: "123")
        
        // Assert
        XCTAssertNotNil(receivedUser)
        XCTAssertEqual(receivedUser, user)
        XCTAssertEqual(receivedUser.id, "123")
        XCTAssertEqual(receivedUser.email, "test@test.gr")
        XCTAssertEqual(receivedUser.name, "Kris")
        XCTAssertEqual(receivedUser.token, token)
    }
    
    func testSignUp() async throws {
        // Arrange
        let (source, restClient) = arrange()
        let expectedMessage = "Reset email sent"
        let token = "123"

        restClient.stub = { path, method, body, headers in
            XCTAssertEqual(path, .signup)
            XCTAssertEqual(method, .post)
            return RAuthResponse(message: expectedMessage,
                                 user: self.rUser,
                                 token: token)
        }

        // Act
        let receivedUser = try await source.signup(name: user.name, email: user.email, password: "123")
        
        // Assert
        XCTAssertNotNil(receivedUser)
        XCTAssertEqual(receivedUser, user)
        XCTAssertEqual(receivedUser.id, "123")
        XCTAssertEqual(receivedUser.email, "test@test.gr")
        XCTAssertEqual(receivedUser.name, "Kris")
        XCTAssertEqual(receivedUser.token, token)
    }
    
    func testForgotPassword() async throws {
        // Arrange
        let (source, restClient) = arrange()
        let expectedMessage = "Reset email sent"
        restClient.stub = { path, method, body, headers in
            XCTAssertEqual(path, .forgotPassword)
            XCTAssertEqual(method, .post)
            return RAuthResponseForgotPassword(message: expectedMessage)
        }
        
        // Act
        let message = try await source.forgotPassword(email: user.email)
        
        // Assert
        XCTAssertEqual(message, expectedMessage)
    }
}
