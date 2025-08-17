//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModule
import AppLogging

final class OnboardingDI: DIContainer {
    static var shared = DIContainer()
    
    let isEmpty: Bool
    
    static func empty() -> OnboardingDI {
        OnboardingDI(empty: true, dependencies: nil)
    }

    init(empty: Bool = false,
         dependencies: Dependencies?) {
        isEmpty = empty
        super.init()

        OnboardingDI.shared = self
        guard !isEmpty else { return }

        registerSources()
        registerRepo()
        registerUceCases()
        
        if dependencies != nil {
            registerLogging()
        }

    }

    private func registerSources() {
        register(OnboardingSource.self) { _ in OnboardingSourceImpl() }
    }

    private func registerRepo() {
        register(OnboardingRepo.self) { _ in OnboardingRepoImpl() }
    }
    
    private func registerUceCases() {
        register(CompleteOnboardingUC.self) { _ in CompleteOnboardingUCImpl() }
    }
    
    // MARK: Register Dependencies
    private func registerLogging() {
        register(BTLogger.self) { _ in logger(module: "Onboarding") }
    }
}
