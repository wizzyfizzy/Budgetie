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
import UIComponents

final class LoginUserUCTests: XCTestCase {
    private func arrange() -> (loginUserUC: LoginUserUC,
                               repo: AuthAPIRepoMock) {
        let repo = AuthAPIRepoMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(AuthAPIRepo.self) { _ in repo }
        
        return (LoginUserUCImpl(), repo)
    }
    private let expectedUser = UserData(id: "42", email: "kris@test.gr", name: "Kris", token: "abc123")
    
    func testExecute_Success() async throws {
        // Arrange
        let (uceCase, repo) = arrange()
        let testEmail = "kris@test.gr"
        let testPass = "123"
        
        repo.stub.loginEmailPassword_Async_UserData = { userData in
            let (email, password) = userData
            XCTAssertEqual(email, testEmail)
            XCTAssertEqual(password, testPass)
            return self.expectedUser
        }
        
        // Act
        let receivedUser = try await uceCase.execute(email: testEmail, password: testPass)
        
        // Assert
        XCTAssertEqual(repo.verify.loginEmailPassword_Async_UserData.count, 1)
        XCTAssertEqual(expectedUser, receivedUser)
    }
    
    func testExecute_Error() async throws {
        // Arrange
        let (uceCase, repo) = arrange()
        
        repo.stub.loginEmailPassword_Async_UserData = { _ in
            throw NSError(domain: "AuthError", code: 401, userInfo: nil)
        }
        
        // Act
        do {
            _ = try await uceCase.execute(email: "kris@test.gr", password: "123")
            XCTFail("Expected error not thrown")
        } catch {
            // Assert
            XCTAssertEqual(repo.verify.loginEmailPassword_Async_UserData.count, 1)
        }
    }
}
