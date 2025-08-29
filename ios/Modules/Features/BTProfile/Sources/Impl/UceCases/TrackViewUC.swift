//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging

// sourcery: AutoMockable
/// Use case responsible for tracking screen views within the app.
///
/// This protocol abstracts the logic for logging or sending analytics events
/// whenever a user navigates to a specific screen or view. Implementations can
/// log the view locally or send it to an analytics backend.
protocol TrackViewUC {
    /// Tracks a view or screen event with a specific file context.
    ///
    /// - Parameters:
    ///   - fileName: The name of the file or component where the view event originated.
    ///   - event: A descriptive name of the view being displayed.
    func execute(fileName: String, event: TrackingView)
}

final class TrackViewUCImpl: TrackViewUC {
    @Injected private var logger: BTLogger
    
    func execute(fileName: String, event: TrackingView) {
        let message: LoggingMessage = "TrackingView: \(event.rawValue)"
        logger.log(.debug, fileName: fileName, message)
    }
}
