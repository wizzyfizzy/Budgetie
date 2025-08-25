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

final class viewModelTests: XCTestCase {
    private func arrange() -> (viewModel: LoginVM,
                               loginUserUC: LoginUserUCMock,
                               saveUserUC: SaveUserSessionUCMock,
                               logger: BTLoggerMock) {
        let saveUserUC = SaveUserSessionUCMock()
        let loginUserUC = LoginUserUCMock()
        let logger = BTLoggerMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(LoginUserUC.self) { _ in loginUserUC }
        AuthDI.shared.register(SaveUserSessionUC.self) { _ in saveUserUC }
        AuthDI.shared.register(BTLogger.self) { _ in logger }
        
        return (LoginVM(),
                loginUserUC,
                saveUserUC,
                logger)
    }
    
    func testEmailValidation_EmptyEmail() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
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
        viewModel.password = "123123"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Please fill in your email.")
    }
    
    func testEmailValidation_InvalidEmail() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
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
        viewModel.password = "123456"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email format.")
    }
    
    func testEmailValidation_Correct() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
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
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testPasswordValidation_WrongPassword() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Password must have at least 6 characters." {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = "test@test.gr"
        viewModel.password = "123"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Password must have at least 6 characters.")
    }
    
    func testPasswordValidation_CorrectPassword() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
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
        viewModel.password = "123123"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testBothValidation_MissingBoth() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Please fill in your email.\nPassword must have at least 6 characters." {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = ""
        viewModel.password = ""
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Please fill in your email.\nPassword must have at least 6 characters.")
    }
    
    func testBothValidation_InvalidEmail_WrongPassword() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Invalid email format.\nPassword must have at least 6 characters." {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = "test"
        viewModel.password = "123"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email format.\nPassword must have at least 6 characters.")
    }
    
    func testTrackView() {
        // Arrange
        let (viewModel, _, _, logger) = arrange()
        
        // Act
        viewModel.trackView()
        
        // Assert
        XCTAssertEqual(logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingView.authSignInScreen)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testOnTapCreateAccount_Tracking() {
        // Arrange
        let (viewModel, _, _, logger) = arrange()
        
        // Act
        viewModel.onTapCreateAccount()
        
        // Assert
        XCTAssertEqual(logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapCreateAccount)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testOnTapForgotPassword_Tracking() {
        // Arrange
        let (viewModel, _, _, logger) = arrange()
        
        // Act
        viewModel.onTapForgotPass()
        
        // Assert
        XCTAssertEqual(logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapForgotPassword)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testLoginWithApple_Tracking() async {
        // Arrange
        let (viewModel, _, _, logger) = arrange()
        
        // Act
        _ = await viewModel.loginWithApple()
        
        // Assert
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignInWithApple)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testLogin_Success() async throws {
        // Arrange
        let (viewModel, loginUC, saveUserUC, logger) = arrange()
        let testEmail = "test@test.gr"
        let user = UserData(id: "1", email: testEmail, name: "Kris", token: "123")
        loginUC.stub.executeEmailPassword_Async_UserData = { _ in user }
        saveUserUC.stub.executeUser_Void = { _ in }
        
        viewModel.email = testEmail
        viewModel.password = "123123"
        
        // Act
        await viewModel.login()
        
        // Assert
        XCTAssertTrue(viewModel.shouldDismissView)
        XCTAssertEqual(loginUC.verify.executeEmailPassword_Async_UserData.first?.email, testEmail)
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.first, user)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)
        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignIn)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
        
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        // Tracking log succedded
        let isCorrectloggingMessageCompleted = logger.verify.logFileName_Void.last?.message.description.contains("\(TrackingAction.completedSignIn)") ?? false
        XCTAssertTrue(isCorrectloggingMessageCompleted)
    }
    
    func testLogin_InvalidCredentials() async throws {
        // Arrange
        let (viewModel, loginUC, saveUserUC, logger) = arrange()
        
        loginUC.stub.executeEmailPassword_Async_UserData = { _ in throw HTTPError.invalidCredentials }
        saveUserUC.stub.executeUser_Void = { _ in }
        
        viewModel.email = "wrong@test.gr"
        viewModel.password = "123123"
        
        // Act
        await viewModel.login()
        
        // Assert
        XCTAssertEqual(viewModel.alert, .error("Login Error", "Invalid email or password"))
        XCTAssertFalse(viewModel.shouldDismissView)
        XCTAssertEqual(loginUC.verify.executeEmailPassword_Async_UserData.first?.email, "wrong@test.gr")
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.count, 0)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)
        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignIn)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
        
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        // Tracking log succedded
        let isCorrectloggingMessageError = logger.verify.logFileName_Void.last?.message.description.contains("Invalid email or password") ?? false
        XCTAssertTrue(isCorrectloggingMessageError)
    }
    
    func testLogin_GenericError() async throws {
        // Arrange
        let (viewModel, loginUC, saveUserUC, logger) = arrange()
        
        loginUC.stub.executeEmailPassword_Async_UserData = { _ in throw NSError(domain: "Test", code: 1) }
        saveUserUC.stub.executeUser_Void = { _ in }
        
        viewModel.email = "test@test.gr"
        viewModel.password = "123123"
        
        // Act
        await viewModel.login()
        
        
        // Assert
        XCTAssertEqual(viewModel.alert, .error("Login Error", "Something went wrong. Please try again later"))
        XCTAssertFalse(viewModel.shouldDismissView)
        XCTAssertEqual(loginUC.verify.executeEmailPassword_Async_UserData.first?.email, "test@test.gr")
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.count, 0)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)
        
        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignIn)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
        
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        // Tracking log succedded
        let isCorrectloggingMessageError = logger.verify.logFileName_Void.last?.message.description.contains("Failed to login in performLogin") ?? false
        XCTAssertTrue(isCorrectloggingMessageError)
    }
    
    func testLoginSuccess_SaveUserFails() async {
        // Arrange
        let (viewModel, loginUC, saveUserUC, logger) = arrange()
        let testEMail = "test@test.gr"
        let user = UserData(id: "1", email: testEMail, name: "Kris", token: "123")

        loginUC.stub.executeEmailPassword_Async_UserData = { _ in user }
        saveUserUC.stub.executeUser_Void = { _ in throw NSError(domain: "Test", code: 1) }
        
        viewModel.email = testEMail
        viewModel.password = "123123"
        
        // Act
        await viewModel.login()
                
        // Assert
        XCTAssertEqual(viewModel.alert, .error("Login Error", "Failed to login. Please try again later"))
        XCTAssertFalse(viewModel.shouldDismissView)
        XCTAssertEqual(loginUC.verify.executeEmailPassword_Async_UserData.first?.email, testEMail)
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.count, 1)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)
        
        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignIn)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
        
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        // Tracking log succedded
        let isCorrectloggingMessageError = logger.verify.logFileName_Void.last?.message.description.contains("Failed to save session in loginSuccess") ?? false
        XCTAssertTrue(isCorrectloggingMessageError)
    }
}
