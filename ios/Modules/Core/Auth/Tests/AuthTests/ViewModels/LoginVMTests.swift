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

final class LoginVMTests: XCTestCase {
    private func arrange() -> (loginVM: LoginVM,
                               saveUserUC: SaveUserSessionUCMock,
                               logger: BTLoggerMock) {
        let saveUserUC = SaveUserSessionUCMock()
        let logger = BTLoggerMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(SaveUserSessionUC.self) { _ in saveUserUC }
        AuthDI.shared.register(BTLogger.self) { _ in logger }
        
        return (LoginVM(),
                saveUserUC,
                logger)
    }
    
    func testEmailValidation_correctPasswordValidation() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.loginVM.email = ""
        arrange.loginVM.password = "123123"
        
        // Assert
        XCTAssertFalse(arrange.loginVM.isLoginButtonEnabled)
        XCTAssertEqual(arrange.loginVM.errorMessage, "Please fill in your email.")
        
        // Act
        arrange.loginVM.email = "test"
        
        // Assert
        XCTAssertFalse(arrange.loginVM.isLoginButtonEnabled)
        XCTAssertEqual(arrange.loginVM.errorMessage, "Invalid email format.")
        
        // Act
        arrange.loginVM.email = "test@test.gr"
        
        // Assert
        XCTAssertTrue(arrange.loginVM.isLoginButtonEnabled)
        XCTAssertNil(arrange.loginVM.errorMessage)
    }
    
    func testPasswordValidation_correctEmailValidation() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.loginVM.email = "test@test.gr"
        arrange.loginVM.password = "123"
        
        // Assert
        XCTAssertFalse(arrange.loginVM.isLoginButtonEnabled)
        XCTAssertEqual(arrange.loginVM.errorMessage, "Password must have at least 6 characters.")
        
        // Act
        arrange.loginVM.password = "123123"
        
        // Assert
        XCTAssertTrue(arrange.loginVM.isLoginButtonEnabled)
        XCTAssertNil(arrange.loginVM.errorMessage)
    }
    
    func testBothValidation() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.loginVM.email = ""
        arrange.loginVM.password = "123"
        
        // Assert
        XCTAssertFalse(arrange.loginVM.isLoginButtonEnabled)
        XCTAssertEqual(arrange.loginVM.errorMessage, "Please fill in your email.\nPassword must have at least 6 characters.")
        
        // Act
        arrange.loginVM.email = "test"
        
        // Assert
        XCTAssertFalse(arrange.loginVM.isLoginButtonEnabled)
        XCTAssertEqual(arrange.loginVM.errorMessage, "Invalid email format.\nPassword must have at least 6 characters.")
    }
    
    func testTrackView() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.loginVM.trackView()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingView.authSignInScreen)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testOnTapCreateAccount_Tracking() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.loginVM.onTapCreateAccount()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapCreateAccount)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testOnTapForgotPassword_Tracking() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.loginVM.onTapForgotPass()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapForgotPassword)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testLoginWithApple_Tracking() async {
        // Arrange
        let arrange = arrange()
        
        // Act
        _ = await arrange.loginVM.loginWithApple()
        
        // Assert
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignInWithApple)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testLogin_Tracking() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.loginVM.email = "test@test.gr"
        arrange.loginVM.password = "123123"
//        arrange.loginVM.login()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignIn)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
    }
}
