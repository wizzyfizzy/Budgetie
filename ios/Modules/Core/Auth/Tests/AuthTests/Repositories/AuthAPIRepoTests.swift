//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import XCTest
@testable import Auth
import AuthAPI
import DIModule

final class AuthAPIRepoTests: XCTestCase {
    private func arrange() -> (repo: AuthAPIRepo,
                               source: AuthAPISourceMock) {
        let source = AuthAPISourceMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(AuthAPISource.self) { _ in source }
        
        return (AuthAPIRepoImpl(), source)
    }
    private let user = UserData(id: "42", email: "test@test.gr", name: "Kris", token: "123")

    func testLoginCall() async throws {
        // Arrange
        let (repo, source) = arrange()
        source.stub.loginEmailPassword_Async_UserData = { _ async throws -> UserData in
            return self.user
        }

        // Act
        let result = try await repo.login(email: "test@test.gr", password: "1234")
        
        // Assert
        XCTAssertEqual(result, user)
        XCTAssertEqual(source.verify.loginEmailPassword_Async_UserData.count, 1)
        XCTAssertEqual(source.verify.loginEmailPassword_Async_UserData.first?.email, "test@test.gr")
    }
    
    func testSignUpCall() async throws {
        // Arrange
        let (repo, source) = arrange()
        source.stub.signupNameEmailPassword_Async_UserData = { 
        _ async throws -> UserData in
            return self.user
        }

        // Act
        let result = try await repo.signup(name: "Kris", email: "test@test.gr", password: "1234")
        
        // Assert
        XCTAssertEqual(result, user)
        XCTAssertEqual(source.verify.signupNameEmailPassword_Async_UserData.count, 1)
        XCTAssertEqual(source.verify.signupNameEmailPassword_Async_UserData.first?.name, "Kris")
        XCTAssertEqual(source.verify.signupNameEmailPassword_Async_UserData.first?.email, "test@test.gr")
    }
    
    func testForgotPasswordCall() async throws {
        // Arrange
        let (repo, source) = arrange()
        let expectedMessage = "Password reset email sent"
        source.stub.forgotPasswordEmail_Async_String = { _ async throws -> String in
            return expectedMessage
        }
        
        // Act
        let message = try await repo.forgotPassword(email: "test@test.gr")
        
        // Assert
        XCTAssertEqual(message, expectedMessage)
        XCTAssertEqual(source.verify.forgotPasswordEmail_Async_String.count, 1)
        XCTAssertEqual(source.verify.forgotPasswordEmail_Async_String.first, "test@test.gr")
    }
}
