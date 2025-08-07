//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import OSLog

// sourcery: AutoMockable
public protocol BTLogger {
    func log(_ type: LoggingType, fileName: String?, _ message: LoggingMessage)
}

/// Creates an instance of `BTLogger` using the default configuration.
/// - Parameter component: The Module name
/// - Returns: An instance of `HCLogger`.
public func logger(module: String) -> BTLogger { BTLoggerImpl(module: module) }

/// Creates an instance of `BTLogger` which does not log anything.
///
/// - Returns: An instance of `BTLogger`.
public func emptyLogger() -> BTLogger { BTLoggerImpl(module: "") }

public final class BTLoggerImpl: BTLogger {

    private let module: String?
    private let logger: OSLoggerProtocol

    public init(module: String? = nil, logger: OSLoggerProtocol? = nil) {
        self.module = module ?? "Main App"
        self.logger = logger ?? BasicOsLogger(
            subsystem: Bundle.main.bundleIdentifier ?? "Budgetie",
            category: module ?? "Main App")
    }

    public func log(_ type: LoggingType, fileName: String?, _ message: LoggingMessage) {
        let logType = "[\(type.rawValue.uppercased())]"
        let module = module.map { "[\($0)]" } ?? ""
        let logFileName = fileName.map { "[\($0)]" } ?? ""
        let fullMessage = "\(logType)\(module)\(logFileName) - \(message.description)"
        switch type {
        case .debug:
            logger.debug(fullMessage)
        case .info:
            logger.info(fullMessage)
        case .warning:
            logger.warning(fullMessage)
        case .error:
            logger.error(fullMessage)
        }
    }
}
