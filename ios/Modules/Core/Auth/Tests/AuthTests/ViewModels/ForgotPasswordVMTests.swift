//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import XCTest
@testable import Auth
import AuthAPI
import AppLogging
import AppLoggingMocks
import DIModule
import BTRestClientAPI

final class ForgotPasswordVMTests: XCTestCase {
    private func arrange() -> (forgotPasswordVM: ForgotPasswordVM,
                               forgotPasswordUC: ForgotPasswordUCMock,
                               logger: BTLoggerMock) {
        let logger = BTLoggerMock()
        let forgotPasswordUC = ForgotPasswordUCMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(ForgotPasswordUC.self) { _ in forgotPasswordUC }
        AuthDI.shared.register(BTLogger.self) { _ in logger }
        
        return (ForgotPasswordVM(),
                forgotPasswordUC,
                logger)
    }
        
    func testEmailValidation_emptyEmail() {
        // Arrange
        let (viewModel, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Please fill in your email." {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = ""

        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isResetButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Please fill in your email.")
    }
    
    func testEmailValidation_invalidEmail() {
        // Arrange
        let (viewModel, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Invalid email format." {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = "test"

        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isResetButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email format.")
    }
    
    func testEmailValidation_validEmail() {
        // Arrange
        let (viewModel, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == nil {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = "test@test.gr"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertTrue(viewModel.isResetButtonEnabled)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testTrackView() {
        // Arrange
        let (viewModel, _, logger) = arrange()

        // Act
        viewModel.trackView()
        
        // Assert
        XCTAssertEqual(logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingView.authForgotPasswordScreen)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testForgotPassword_success() async throws {
        // Arrange
        let (viewModel, forgotPasswordUC, logger) = arrange()
        forgotPasswordUC.stub.executeEmail_Async_String = { email in
            return "Password reset email sent to \(email)"
        }
        
        viewModel.email = "kris@test.gr"
        
        // Act
        await viewModel.forgotPassword()
        
        // Assert
        XCTAssertEqual(forgotPasswordUC.verify.executeEmail_Async_String.first, "kris@test.gr")
        XCTAssertEqual(viewModel.alert, .success("Success", "Password reset email sent to kris@test.gr"))
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)

        // Logging check
        let isCorrectLog = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapForgotPassword)") ?? false
        XCTAssertTrue(isCorrectLog)
    }
    
    func testForgotPassword_InvalidEmailError() async throws {
        // Arrange
        let (viewModel, forgotPasswordUC, logger) = arrange()
        forgotPasswordUC.stub.executeEmail_Async_String = { _ in
            throw HTTPError.missingFields
        }
        
        viewModel.email = "kris@test.gr"
        
        // Act
        await viewModel.forgotPassword()
        
        // Assert
        XCTAssertEqual(viewModel.alert, .error("Error", "Invalid email"))
        
        let isCorrectLog = logger.verify.logFileName_Void.last?.message.description.contains("Invalid email") ?? false
        XCTAssertTrue(isCorrectLog)
    }
    
    func testForgotPassword_GenericError() async throws {
        // Arrange
        let (viewModel, forgotPasswordUC, _) = arrange()
        forgotPasswordUC.stub.executeEmail_Async_String = { _ in
            throw URLError(.notConnectedToInternet)
        }
        
        viewModel.email = "kris@test.gr"
        
        // Act
        await viewModel.forgotPassword()
        
        // Assert
        XCTAssertEqual(viewModel.alert, .error("Error", "Something went wrong. Please try again later"))
    }

    private func checktracking(logger: BTLoggerMock) {
        XCTAssertEqual(logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapForgotPassword)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
    }
}
