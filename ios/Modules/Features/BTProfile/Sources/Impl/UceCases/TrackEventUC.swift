//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging

// sourcery: AutoMockable
/// Use case responsible for tracking user events within the app.
///
/// This protocol abstracts the logic for logging or sending analytics events.
/// Implementations can log events locally, send them to an analytics backend,
/// or both.
protocol TrackEventUC {
    /// Tracks a user action with a specific file context.
    ///
    /// - Parameters:
    ///   - fileName: The name of the file or component where the event originated.
    ///   - event: A descriptive name of the action performed by the user.
    func execute(fileName: String, event: LoggingMessage)
}

final class TrackEventUCImpl: TrackEventUC {
    @Injected private var logger: BTLogger
    
    func execute(fileName: String, event: LoggingMessage) {
        let message: LoggingMessage = "Tracking Event: \(event)"
        logger.log(.debug, fileName: fileName, message)
    }
}
