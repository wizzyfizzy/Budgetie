//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

// sourcery: AutoMockable
protocol OnboardingSource {
    func hasSeenOnboarding() -> Bool
    func completeOnboarding()
}

struct OnboardingSourceImpl: OnboardingSource {
    @Injected private var userDefaults: UserDefaults

    func hasSeenOnboarding() -> Bool {
        userDefaults.isOnboardingCompleted
    }

    func completeOnboarding() {
        userDefaults.isOnboardingCompleted = true
    }
}
