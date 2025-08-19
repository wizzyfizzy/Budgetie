//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import UIComponents

// sourcery: AutoMockable
protocol OnboardingSource {
    func hasSeenOnboarding() -> Bool
    func completeOnboarding()
}

struct OnboardingSourceImpl: OnboardingSource {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func hasSeenOnboarding() -> Bool {
        userDefaults.isOnboardingCompleted
    }

    func completeOnboarding() {
        userDefaults.isOnboardingCompleted = true
    }
}
