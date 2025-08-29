//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModule
import AppLogging
import Foundation

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
        
        if let dep = dependencies {
            registerDependencies(dep)
        }
        registerSources()
        registerRepo()
        registerUceCases()
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
    private func registerDependencies(_ dependencies: Dependencies) {
        register(BTLogger.self) { _ in logger(module: "Onboarding") }
        register(UserDefaults.self) { _ in dependencies.userDefaults }
    }
}
