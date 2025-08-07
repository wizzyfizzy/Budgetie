// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
// swiftlint:disable all
// swiftformat:disable all
import Foundation
import Combine
@testable import AppLogging
public final class BTLoggerMock: BTLogger {

    public init() {}

    // MARK: - Stub
    public final class Stub {
    }

    // MARK: - Verify
    public final class Verify {
        public var logFileName_Void: [(type: LoggingType, fileName: String?, message: LoggingMessage)] = []
    }

    public let stub = Stub()
    public let verify = Verify()
    public func log(_ type: LoggingType, fileName: String?, _ message: LoggingMessage) {
        verify.logFileName_Void.append((type, fileName, message))
    }
}
