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

final class ForgotPasswordVMTests: XCTestCase {
    private func arrange() -> (forgotPasswordVM: ForgotPasswordVM,
                               logger: BTLoggerMock) {
        let logger = BTLoggerMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(BTLogger.self) { _ in logger }
        
        return (ForgotPasswordVM(),
                logger)
    }
        
    func testEmailValidation_emptyEmail() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.forgotPasswordVM.email = ""

        // Assert
        XCTAssertFalse(arrange.forgotPasswordVM.isResetButtonEnabled)
        XCTAssertEqual(arrange.forgotPasswordVM.errorMessage, "Please fill in your email.")
    }
    
    func testEmailValidation_invalidEmail() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.forgotPasswordVM.email = "test"
        
        // Assert
        XCTAssertFalse(arrange.forgotPasswordVM.isResetButtonEnabled)
        XCTAssertEqual(arrange.forgotPasswordVM.errorMessage, "Invalid email format.")
    }
    
    func testEmailValidation_validEmail() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.forgotPasswordVM.email = "test@test.gr"
        
        // Assert
        XCTAssertTrue(arrange.forgotPasswordVM.isResetButtonEnabled)
        XCTAssertNil(arrange.forgotPasswordVM.errorMessage)
    }
    
    func testResetPassword_success() {
        // Arrange
        let arrange = arrange()
        let expectation = XCTestExpectation(description: "Completion called")
        // Act
        arrange.forgotPasswordVM.email = "valid@email.com"

        arrange.forgotPasswordVM.resetPassword { [weak self] success in
            self?.checktracking(logger: arrange.logger)
            XCTAssertTrue(success)
            XCTAssertNil(arrange.forgotPasswordVM.errorMessage)
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 2)
    }
    
    func testTrackView() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.forgotPasswordVM.trackView()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingView.authForgotPasswordScreen)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    private func checktracking(logger: BTLoggerMock) {
        XCTAssertEqual(logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapForgotPassword)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
    }
}
