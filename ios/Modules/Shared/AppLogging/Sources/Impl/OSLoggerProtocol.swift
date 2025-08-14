//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import OSLog

public protocol OSLoggerProtocol {
    func debug(_ message: String)
    func info(_ message: String)
    func warning(_ message: String)
    func error(_ message: String)
}

public final class BasicOsLogger: OSLoggerProtocol {
    private let logger: Logger
    
    public init(subsystem: String, category: String) {
        self.logger = Logger(subsystem: subsystem, category: category)
    }
    
    public func debug(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }
    public func info(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }
    
    public func warning(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }
    
    public func error(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }
    
}
