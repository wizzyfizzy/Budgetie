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

final class SignUpVMTests: XCTestCase {
    private func arrange() -> (signUpVM: SignUpVM,
                               saveUserUC: SaveUserSessionUCMock,
                               logger: BTLoggerMock) {
        let saveUserUC = SaveUserSessionUCMock()
        let logger = BTLoggerMock()
        AuthDI.shared = DIContainer()
        AuthDI.shared.register(SaveUserSessionUC.self) { _ in saveUserUC }
        AuthDI.shared.register(BTLogger.self) { _ in logger }
        
        return (SignUpVM(),
                saveUserUC,
                logger)
    }
    
    func testNameValidation() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.signUpVM.name = ""
        arrange.signUpVM.email = "test@test.gr"
        arrange.signUpVM.password = "123123"
        arrange.signUpVM.confirmPassword = "123123"
        arrange.signUpVM.agreeTerms = true
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Please fill in your name.")
        
        // Act
        arrange.signUpVM.name = "I"
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Name must have at least 2 characters.")
        
        // Act
        arrange.signUpVM.name = "test"
        
        // Assert
        XCTAssertTrue(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertNil(arrange.signUpVM.errorMessage)
    }
    
    func testEmailValidation() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.signUpVM.name = "Kris"
        arrange.signUpVM.email = ""
        arrange.signUpVM.password = "123123"
        arrange.signUpVM.confirmPassword = "123123"
        arrange.signUpVM.agreeTerms = true
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Please fill in your email.")
        
        // Act
        arrange.signUpVM.email = "test"
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Invalid email format.")
        
        // Act
        arrange.signUpVM.email = "test@test.gr"
        
        // Assert
        XCTAssertTrue(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertNil(arrange.signUpVM.errorMessage)
    }
    
    func testPasswordValidation() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.signUpVM.name = "Kris"
        arrange.signUpVM.email = "test@test.gr"
        arrange.signUpVM.password = "123"
        arrange.signUpVM.agreeTerms = true
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Password must have at least 6 characters.")
        
        // Act
        arrange.signUpVM.password = "123123"
        arrange.signUpVM.confirmPassword = "123"
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Passwords do not match.")
        
        //        // Act
        arrange.signUpVM.password = "123123"
        arrange.signUpVM.confirmPassword = "123123"
        // Assert
        XCTAssertTrue(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertNil(arrange.signUpVM.errorMessage)
    }
    
    func testValidation() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.signUpVM.email = ""
        arrange.signUpVM.password = "123"
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Please fill in your name.\nPlease fill in your email.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions")
        
        // Act
        arrange.signUpVM.email = "test"
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Please fill in your name.\nInvalid email format.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions")
        
        arrange.signUpVM.name = "Test"
        
        // Assert
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Invalid email format.\nPassword must have at least 6 characters.\nPlease accept Terms and conditions")
        
        arrange.signUpVM.password = "123123"
        arrange.signUpVM.confirmPassword = "123"
        
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Invalid email format.\nPasswords do not match.\nPlease accept Terms and conditions")
        
        arrange.signUpVM.password = "123123"
        arrange.signUpVM.confirmPassword = "123123"
        
        XCTAssertFalse(arrange.signUpVM.isSignUpButtonEnabled)
        XCTAssertEqual(arrange.signUpVM.errorMessage, "Invalid email format.\nPlease accept Terms and conditions")
        
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
    
    func testSignUp() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.signUpVM.name = "Kris"
        arrange.signUpVM.email = "test@test.gr"
        arrange.signUpVM.password = "123123"
        arrange.signUpVM.confirmPassword = "123123"
        arrange.signUpVM.agreeTerms = true
        arrange.signUpVM.signUp()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        let isCorrectloggingMessage = arrange.logger.verify.logFileName_Void.first?.message.description.contains("\(TrackingAction.tapSignUp)") ?? false
        XCTAssertTrue(isCorrectloggingMessage)
    }
}
