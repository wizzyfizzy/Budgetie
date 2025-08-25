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
        let arrange = arrange()
        arrange.source.stub.loginEmailPassword_Async_UserData = { userData async throws -> UserData in
            let (email, password) = userData
            return self.user
        }

        // Act
        let result = try await arrange.repo.login(email: "test@test.gr", password: "1234")
        
        // Assert
        XCTAssertEqual(result, user)
        XCTAssertEqual(arrange.source.verify.loginEmailPassword_Async_UserData.count, 1)
        XCTAssertEqual(arrange.source.verify.loginEmailPassword_Async_UserData.first?.email, "test@test.gr")
    }
    
    func testSignUpCall() async throws {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.signupNameEmailPassword_Async_UserData = { userData async throws -> UserData in
            let (name, email, password) = userData
            return self.user
        }

        // Act
        let result = try await arrange.repo.signup(name: "Kris", email: "test@test.gr", password: "1234")
        
        // Assert
        XCTAssertEqual(result, user)
        XCTAssertEqual(arrange.source.verify.signupNameEmailPassword_Async_UserData.count, 1)
        XCTAssertEqual(arrange.source.verify.signupNameEmailPassword_Async_UserData.first?.name, "Kris")
        XCTAssertEqual(arrange.source.verify.signupNameEmailPassword_Async_UserData.first?.email, "test@test.gr")
    }
    
    func testForgotPasswordCall() async throws {
        // Arrange
        let arrange = arrange()
        let expectedMessage = "Password reset email sent"
        arrange.source.stub.forgotPasswordEmail_Async_String = { _ async throws -> String in
            return expectedMessage
        }
        
        // Act
        let message = try await arrange.repo.forgotPassword(email: "test@test.gr")
        
        // Assert
        XCTAssertEqual(message, expectedMessage)
        XCTAssertEqual(arrange.source.verify.forgotPasswordEmail_Async_String.count, 1)
        XCTAssertEqual(arrange.source.verify.forgotPasswordEmail_Async_String.first, "test@test.gr")
    }
}
