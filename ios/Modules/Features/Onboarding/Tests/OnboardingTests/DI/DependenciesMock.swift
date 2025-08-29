//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Onboarding
import AppLoggingMocks
import Foundation

extension Dependencies {
    static func mock() -> Dependencies {
        let suiteName = "OnboardingTests"
        let userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
        userDefaults.removePersistentDomain(forName: suiteName)
        return Dependencies(logger: { BTLoggerMock() },
                            userDefaults: userDefaults)
    }
}
