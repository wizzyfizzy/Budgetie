//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import OnboardingAPI

public class ShouldShowOnboardingUCImpl: ShouldShowOnboardingUC {
    @Injected private var repo: OnboardingRepo

    public init() {}

    public func execute() -> Bool {
        !repo.hasSeenOnboarding()
    }
}
