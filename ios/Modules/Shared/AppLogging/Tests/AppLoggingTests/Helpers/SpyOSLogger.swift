//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import AppLogging

/// A spy implementation of `OSLoggerProtocol`, used to capture and verify log messages during unit tests.
///
/// Instead of performing actual logging, it stores messages per log level
/// in arrays so that they can be asserted in tests.
final class SpyOSLogger: OSLoggerProtocol {
    private(set) var debugMessages: [String] = []
    private(set) var infoMessages: [String] = []
    private(set) var warningMessages: [String] = []
    private(set) var errorMessages: [String] = []

    func debug(_ message: String) {
        debugMessages.append(message)
    }

    func info(_ message: String) {
        infoMessages.append(message)
    }

    func warning(_ message: String) {
        warningMessages.append(message)
    }

    func error(_ message: String) {
        errorMessages.append(message)
    }
}
