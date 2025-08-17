//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

// sourcery: AutoMockable
protocol OnboardingRepo {
    func hasSeenOnboarding() -> Bool
    func completeOnboarding()
}

struct OnboardingRepoImpl: OnboardingRepo {
    @Injected private var source: OnboardingSource
    
    public func hasSeenOnboarding() -> Bool {
        source.hasSeenOnboarding()
    }
    
    public func completeOnboarding() {
        source.completeOnboarding()
    }
}
