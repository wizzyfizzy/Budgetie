//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import OnboardingAPI
import Onboarding
import AppLogging

extension BTAppDI {
    func initOnboarding() {
        let dependencies = Onboarding.Dependencies(logger: { logger(module: "Onboarding") })
        OnboardingInitializer.initialize(dependencies: dependencies)
    }
    
    func registerOnboarding() {
        register(ShouldShowOnboardingUC.self) { _ in ShouldShowOnboardingUCImpl()}
    }
}
