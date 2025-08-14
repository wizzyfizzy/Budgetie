//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import XCTest
@testable import AppLogging
import OSLog

final class BTLoggerTests: XCTestCase {
    private func arrange() -> (logger: BTLoggerImpl,
                               spyLogger: SpyOSLogger) {
        let spyLogger = SpyOSLogger()
        let logger = BTLoggerImpl(module: "TestModule", logger: spyLogger)
        
        return (logger, spyLogger)
    }
    
    func testLog() throws {
        let userId = "userId"
        let message: LoggingMessage = "User with id: \(id: userId) opened onboarding"
        
        LoggingType.allCases.forEach { type in
            logger(module: "Onboarding")
                .log(type, fileName: "OnboardingRepo", message)
        }
        
        LoggingType.allCases.forEach { level in
            logger(module: "Onboarding")
                .log(level, fileName: nil, message)
        }
        
        LoggingType.allCases.forEach { level in
            emptyLogger()
                .log(level, fileName: "OnboardingRepo", message)
        }
    }
    
    func testLoggingMessage() {
        let arrange = arrange()
        let message: LoggingMessage = "User logged in with id: \(id: "12345")"
        
        arrange.logger.log(.debug, fileName: "LoginView.swift", message)
        XCTAssertEqual(message.description, "User logged in with id: {\"id\": \"12345\"}")
    }
    
    func testLoggingMessage_interpolations() throws {
        let rawJson = """
            {
                "email": "user@example.com",
                "password": "123456"
            }
            """
        let json = try XCTUnwrap(rawJson.data(using: .utf8), "Failed to convert JSON string to Data")

        let msg: LoggingMessage = "Payload: \(json: json)"
        XCTAssertTrue(msg.description.contains("********"))
    }
    
    func testLoggingMessage_ObfuscatableInterpolation() {
        struct Secret: Obfuscatable {
            func obfuscated() -> String {
                return "REDACTED"
            }
        }
        let message: LoggingMessage = "Token: \(Secret())"
        XCTAssertEqual(message.description, "Token: REDACTED")
    }
    
    func testLoggingMessag_ObfuscationInsideCustomStruct() {
        struct Token: Obfuscatable {
            let value = "abc123"
            func obfuscated() -> String { "xxx" }
        }
        let message: LoggingMessage = "token = \(Token())"
        XCTAssertEqual(message.description, "token = xxx")
    }
    
    func testLoggingNumbers() {
        let amount: Double = 3.1415
        let msg: LoggingMessage = "π = \(amount)"
        XCTAssertTrue(msg.description.contains("π = 3.1415"))
    }
    
    func testLoggingMessage_withEmojisAndSymbols() {
        let message: LoggingMessage = "🌈✨🔒🔑 – such a nice message!!"
        XCTAssertTrue(message.description.contains("🌈✨🔒🔑"))
    }

    func testLog_Empty() {
        // Arrange
        let arrange = arrange()
        
        // Assert
        XCTAssertEqual(arrange.spyLogger.debugMessages, [])
        XCTAssertEqual(arrange.spyLogger.infoMessages, [])
        XCTAssertEqual(arrange.spyLogger.warningMessages, [])
        XCTAssertEqual(arrange.spyLogger.errorMessages, [])
    }
    
    func testLog_debug() {
        // Arrange
        let arrange = arrange()
        let expectedType: LoggingType = .debug
        let expectedFileName = "LoginView"
        let message: LoggingMessage = "User login failed for id: \(id: "abc123")"
        let expectedMessage = "[DEBUG][TestModule][\(expectedFileName)] - \(message)"

        // Act
        arrange.logger.log(expectedType, fileName: expectedFileName, message)
        
        // Assert
        XCTAssertEqual(arrange.spyLogger.debugMessages.count, 1)
        XCTAssertEqual(arrange.spyLogger.infoMessages, [])
        XCTAssertEqual(arrange.spyLogger.warningMessages, [])
        XCTAssertEqual(arrange.spyLogger.errorMessages, [])
        guard let logged = arrange.spyLogger.debugMessages.first else {
            XCTFail("No log captured")
            return
        }
        XCTAssertEqual(logged, expectedMessage)
    }
    
    func testLog_info() {
        // Arrange
        let arrange = arrange()
        let expectedType: LoggingType = .info
        let expectedFileName = "LoginView"
        let message: LoggingMessage = "User login failed for id: \(id: "abc123")"
        let expectedMessage = "[INFO][TestModule][\(expectedFileName)] - \(message)"

        // Act
        arrange.logger.log(expectedType, fileName: expectedFileName, message)
        
        // Assert
        XCTAssertEqual(arrange.spyLogger.debugMessages, [])
        XCTAssertEqual(arrange.spyLogger.infoMessages.count, 1)
        XCTAssertEqual(arrange.spyLogger.warningMessages, [])
        XCTAssertEqual(arrange.spyLogger.errorMessages, [])
        guard let logged = arrange.spyLogger.infoMessages.first else {
            XCTFail("No log captured")
            return
        }
        XCTAssertEqual(logged, expectedMessage)
    }
    
    func testLog_warning() {
        // Arrange
        let arrange = arrange()
        let expectedType: LoggingType = .warning
        let expectedFileName = "LoginView"
        let message: LoggingMessage = "User login failed for id: \(id: "abc123")"
        let expectedMessage = "[WARNING][TestModule][\(expectedFileName)] - \(message)"

        // Act
        arrange.logger.log(expectedType, fileName: expectedFileName, message)
        
        // Assert
        XCTAssertEqual(arrange.spyLogger.debugMessages, [])
        XCTAssertEqual(arrange.spyLogger.infoMessages, [])
        XCTAssertEqual(arrange.spyLogger.warningMessages.count, 1)
        XCTAssertEqual(arrange.spyLogger.errorMessages, [])
        guard let logged = arrange.spyLogger.warningMessages.first else {
            XCTFail("No log captured")
            return
        }
        XCTAssertEqual(logged, expectedMessage)
    }
    
    func testLog_Error() {
        // Arrange
        let arrange = arrange()
        let expectedType: LoggingType = .error
        let expectedFileName = "LoginView"
        let message: LoggingMessage = "User login failed for id: \(id: "abc123")"
        let expectedMessage = "[ERROR][TestModule][\(expectedFileName)] - \(message)"

        // Act
        arrange.logger.log(expectedType, fileName: expectedFileName, message)
        
        // Assert
        XCTAssertEqual(arrange.spyLogger.debugMessages, [])
        XCTAssertEqual(arrange.spyLogger.infoMessages, [])
        XCTAssertEqual(arrange.spyLogger.warningMessages, [])
        XCTAssertEqual(arrange.spyLogger.errorMessages.count, 1)
        guard let logged = arrange.spyLogger.errorMessages.first else {
            XCTFail("No log captured")
            return
        }
        XCTAssertEqual(logged, expectedMessage)
    }
    
    func testLog_ObfuscatedMessage() {
        // Arrange
        let arrange = arrange()
        let expectedType: LoggingType = .debug
        let password = "secret12345"
        let expectedFileName = "LoginVM"
        let message: LoggingMessage = "Token: \(password, keep: 3)"
        
        // Act
        arrange.logger.log(expectedType, fileName: expectedFileName, message)
        
        // Assert
        guard let logged = arrange.spyLogger.debugMessages.first else {
            XCTFail("No log captured")
            return
        }
        XCTAssertTrue(logged.contains("sec*******"))
        XCTAssertFalse(logged.contains("secret12345"))
    }
    
    func testLog_withoutFileName() {
        // Arrange
        let arrange = arrange()
        let message = LoggingMessage("message without filename")
        let expected = "[INFO][TestModule] - message without filename"

        // Act
        arrange.logger.log(.info, fileName: nil, message)

        // Assert
        XCTAssertEqual(arrange.spyLogger.infoMessages.first, expected)
    }

    func testLog_withoutModule() {
        // Arrange
        let arrange = arrange()
        let logger = BTLoggerImpl(module: nil, logger: arrange.spyLogger)
        let fileName = "Home"
        let message = LoggingMessage("no module")
        let expected = "[DEBUG][Main App] - no module"
        let expectedWithFileName = "[DEBUG][Main App][\(fileName)] - no module"

        // Act
        logger.log(.debug, fileName: nil, message)
        // Assert
        XCTAssertEqual(arrange.spyLogger.debugMessages.first, expected)

        // Act add fileName
        logger.log(.debug, fileName: fileName, message)
        // Assert
        XCTAssertEqual(arrange.spyLogger.debugMessages.count, 2)
        XCTAssertEqual(arrange.spyLogger.debugMessages[1], expectedWithFileName)
    }
}
