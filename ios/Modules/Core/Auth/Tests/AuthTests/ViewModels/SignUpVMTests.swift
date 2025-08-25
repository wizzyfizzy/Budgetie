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

final class SignUpVMTests: XCTestCase {
    private func arrange() -> (signUpVM: SignUpVM,
                               saveUserUC: SaveUserSessionUCMock,
                               signUpUserUC: SignUpUserUCMock,
                               logger: BTLoggerMock) {
        let saveUserUC = SaveUserSessionUCMock()
        let signUpUserUC = SignUpUserUCMock()
        let logger = BTLoggerMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(SaveUserSessionUC.self) { _ in saveUserUC }
        AuthDI.shared.register(SignUpUserUC.self) { _ in signUpUserUC }
        AuthDI.shared.register(BTLogger.self) { _ in logger }
        
        return (SignUpVM(),
                saveUserUC,
                signUpUserUC,
                logger)
    }
    
    func testNameValidation_EmptyName() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Please fill in your name." {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.name = ""
        viewModel.email = "test@test.gr"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Please fill in your name.")
    }
    
    func testNameValidation_InvalidName() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Name must have at least 2 characters." {
                fulfilled = true
                exp.fulfill()
            }
        }
        // Act
        viewModel.name = "I"
        viewModel.email = "test@test.gr"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Name must have at least 2 characters.")
    }
    
    func testNameValidation_ValidName() {
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
        viewModel.name = "test"
        viewModel.email = "test@test.gr"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
                
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertTrue(viewModel.isSignUpButtonEnabled)
        XCTAssertNil(viewModel.errorMessage)
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
        viewModel.name = "Kris"
        viewModel.email = ""
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
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
        viewModel.name = "Kris"
        viewModel.email = "test"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
                
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email format.")
    }
    
    func testEmailValidation_ValidEmail() {
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
        viewModel.name = "Kris"
        viewModel.email = "test@test.gr"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertTrue(viewModel.isSignUpButtonEnabled)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testPasswordValidation_InvalidPassword() {
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
        viewModel.name = "Kris"
        viewModel.email = "test@test.gr"
        viewModel.password = "123"
        viewModel.agreeTerms = true
        
        // Assert
        wait(for: [exp], timeout: 1)
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Password must have at least 6 characters.")
        cancellable.cancel()
    }
    
    func testPasswordValidation_PasswordsNotMatch() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Passwords do not match." {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.name = "Kris"
        viewModel.email = "test@test.gr"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123"
        viewModel.agreeTerms = true

        // Assert
        wait(for: [exp], timeout: 1)
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Passwords do not match.")
        cancellable.cancel()
    }
    
    
    func testPasswordValidation_ValidPasswords() {
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
        viewModel.name = "Kris"
        viewModel.email = "test@test.gr"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Assert
        wait(for: [exp], timeout: 1)
        XCTAssertTrue(viewModel.isSignUpButtonEnabled)
        XCTAssertNil(viewModel.errorMessage)
        cancellable.cancel()
    }
    
    func testValidation_AllEmpty() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Please fill in your name.\nPlease fill in your email.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions" {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = ""
        viewModel.password = "123"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()        
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Please fill in your name.\nPlease fill in your email.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions")
    }
    
    func testValidation_AllInvalid() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Please fill in your name.\nInvalid email format.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions" {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = ""
        viewModel.password = "123"
        viewModel.email = "test"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()        
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Please fill in your name.\nInvalid email format.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions")
    }
    
    func testValidation_CorrectName() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Invalid email format.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions" {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = ""
        viewModel.password = "123"
        viewModel.email = "test"
        viewModel.name = "Test"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email format.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions")
    }
    
    func testValidation_PasswordsDontMatch() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Invalid email format.\nPasswords do not match.\nPlease accept Terms and conditions" {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = ""
        viewModel.password = "123123"
        viewModel.confirmPassword = "123"
        viewModel.email = "test"
        viewModel.name = "Test"

        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email format.\nPasswords do not match.\nPlease accept Terms and conditions")
    }
    
    func testValidation_InvalidEmailToggleOff() {
        // Arrange
        let (viewModel, _, _, _) = arrange()
        var fulfilled = false
        let exp = expectation(description: "Wait for validation")
        let cancellable = viewModel.$errorMessage.sink { error in
            if !fulfilled, error == "Invalid email format.\nPlease accept Terms and conditions" {
                fulfilled = true
                exp.fulfill()
            }
        }
        
        // Act
        viewModel.email = ""
        viewModel.email = "test"
        viewModel.name = "Test"
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        
        // Assert
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.isSignUpButtonEnabled)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email format.\nPlease accept Terms and conditions")
    }
    
    func testTrackView() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.signUpVM.trackView()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingView.authSignUpScreen)") ?? false
        
        XCTAssertTrue(isCorrectloggingMessage)
    }
    
    func testSignUp_Success() async throws {
        // Arrange
        let (viewModel, saveUserUC, signUpUC, logger) = arrange()
        let testEmail = "test@test.gr"

        let user = UserData(id: "1", email: testEmail, name: "Kris", token: "123")
        signUpUC.stub.executeNameEmailPassword_Async_UserData = { _ in user }
        saveUserUC.stub.executeUser_Void = { _ in }
            
        viewModel.name = "Kris"
        viewModel.email = testEmail
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Act
        await viewModel.signUp()
        
        // Assert
        XCTAssertTrue(viewModel.shouldDismissView)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        XCTAssertEqual(signUpUC.verify.executeNameEmailPassword_Async_UserData.first?.email, testEmail)
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.first, user)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)

        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignUp)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)

        // Tracking log succedded
        let isCorrectloggingMessageCompleted = logger.verify.logFileName_Void.last?.message.description.contains("\(TrackingAction.completedSignUp)") ?? false
        XCTAssertTrue(isCorrectloggingMessageCompleted)
    }
    
    func testSignUp_UserExists() async throws {
        // Arrange
        let (viewModel, saveUserUC, signUpUC, logger) = arrange()
        let testEmail = "test@test.gr"
        signUpUC.stub.executeNameEmailPassword_Async_UserData = { _ in throw HTTPError.userExists }
        saveUserUC.stub.executeUser_Void = { _ in }
            
        viewModel.name = "Kris"
        viewModel.email = testEmail
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Act
        await viewModel.signUp()
        
        // Assert
        XCTAssertFalse(viewModel.shouldDismissView)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        XCTAssertEqual(viewModel.alert, .error("Sign Up failed", "This user already exists"))

        XCTAssertEqual(signUpUC.verify.executeNameEmailPassword_Async_UserData.first?.email, testEmail)
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.count, 0)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)

        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignUp)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)

        // Tracking log succedded
        let isCorrectloggingMessageCompleted = logger.verify.logFileName_Void.last?.message.description.contains("This user already exists") ?? false
        XCTAssertTrue(isCorrectloggingMessageCompleted)
    }
    
    func testSignUp_GenericError() async throws {
        // Arrange
        let (viewModel, saveUserUC, signUpUC, logger) = arrange()
        let testEmail = "test@test.gr"
        signUpUC.stub.executeNameEmailPassword_Async_UserData = { _ in throw NSError(domain: "Test", code: 1) }
        saveUserUC.stub.executeUser_Void = { _ in }
            
        viewModel.name = "Kris"
        viewModel.email = testEmail
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Act
        await viewModel.signUp()
        
        // Assert
        XCTAssertFalse(viewModel.shouldDismissView)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        XCTAssertEqual(viewModel.alert, .error("Error", "Something went wrong. Please try again later"))

        XCTAssertEqual(signUpUC.verify.executeNameEmailPassword_Async_UserData.first?.email, testEmail)
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.count, 0)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)

        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignUp)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)

        // Tracking log succedded
        let isCorrectloggingMessageCompleted = logger.verify.logFileName_Void.last?.message.description.contains("Something went wrong in signUp") ?? false
        XCTAssertTrue(isCorrectloggingMessageCompleted)
    }
    
    func testSignUp_SaveUserFails() async {
        // Arrange
        let (viewModel, saveUserUC, signUpUC, logger) = arrange()
        let testEmail = "test@test.gr"

        let user = UserData(id: "1", email: testEmail, name: "Kris", token: "123")
        signUpUC.stub.executeNameEmailPassword_Async_UserData = { _ in user }
        saveUserUC.stub.executeUser_Void = { _ in throw NSError(domain: "Test", code: 1) }
        
        viewModel.name = "Kris"
        viewModel.email = testEmail
        viewModel.password = "123123"
        viewModel.confirmPassword = "123123"
        viewModel.agreeTerms = true
        
        // Act
        await viewModel.signUp()
        
        // Assert
        XCTAssertFalse(viewModel.shouldDismissView)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        
        XCTAssertEqual(viewModel.alert, .error("Error", "Failed to signUp. Please try again later"))

        XCTAssertEqual(signUpUC.verify.executeNameEmailPassword_Async_UserData.first?.email, testEmail)
        XCTAssertEqual(saveUserUC.verify.executeUser_Void.count, 1)
        XCTAssertEqual(logger.verify.logFileName_Void.count, 2)

        // Tracking log tapped
        let isCorrectloggingMessage = logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignUp)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)

        // Tracking log succedded
        let isCorrectloggingMessageCompleted = logger.verify.logFileName_Void.last?.message.description.contains("Failed to save session in signUpSuccess") ?? false
        XCTAssertTrue(isCorrectloggingMessageCompleted)
    }
}
