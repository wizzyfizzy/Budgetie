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

final class ForgotPasswordUCTests: XCTestCase {
    private func arrange() -> (forgotPasswordUC: ForgotPasswordUC,
                               repo: AuthAPIRepoMock) {
        let repo = AuthAPIRepoMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(AuthAPIRepo.self) { _ in repo }
        
        return (ForgotPasswordUCImpl(), repo)
    }
    
    func testExecute_Success() async throws {
        // Arrange
        let (useCase, repo) = arrange()
        let expectedMessage = "Reset email sent"
        let testEmail = "test@test.gr"
        
        repo.stub.forgotPasswordEmail_Async_String = { email in
            XCTAssertEqual(email, testEmail)
            return expectedMessage
        }
        
        // Act
        let message = try await useCase.execute(email: testEmail)
        
        // Assert
        XCTAssertEqual(repo.verify.forgotPasswordEmail_Async_String.count, 1)
        XCTAssertEqual(expectedMessage, message)
    }
    
    func testExecute_Error() async throws {
        // Arrange
        let (useCase, repo) = arrange()

        repo.stub.forgotPasswordEmail_Async_String = { _ in
            throw URLError(.notConnectedToInternet)
        }
        
        // Act
        do {
            _ = try await useCase.execute(email: "test@test.gr")
            XCTFail("Expected error not thrown")
        } catch {
            // Assert
            XCTAssertTrue(error is URLError)
        }
    }
    
    func testForgotPasswordUC_MultipleCalls() async throws {
        // Arrange
        let (useCase, repo) = arrange()
        repo.stub.forgotPasswordEmail_Async_String = { email in
            return "Reset sent to \(email)"
        }
             
        // Act
        let first = try await useCase.execute(email: "a@test.gr")
        let second = try await useCase.execute(email: "b@test.gr")
        
        // Assert
        XCTAssertEqual(first, "Reset sent to a@test.gr")
        XCTAssertEqual(second, "Reset sent to b@test.gr")
        XCTAssertEqual(repo.verify.forgotPasswordEmail_Async_String, ["a@test.gr", "b@test.gr"])
    }

}
