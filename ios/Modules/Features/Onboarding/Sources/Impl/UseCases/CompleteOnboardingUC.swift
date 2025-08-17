//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

// sourcery: AutoMockable
protocol CompleteOnboardingUC {
    func execute()
}

class CompleteOnboardingUCImpl: CompleteOnboardingUC {
    @Injected private var repo: OnboardingRepo
    
    func execute() {
        repo.completeOnboarding()
    }
}
