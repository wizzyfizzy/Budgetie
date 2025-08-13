//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModule
import AppLogging
import OnboardingAPI
import Onboarding
import AppNavigationAPI
import AppNavigation

final class BTAppDI: DIContainer {
    // Shared singleton instance of type DIContainer
    static var shared = DIContainer()

    let navigationRegistry: NavigationRegistryProtocol
    private(set) var navigationContext: NavigationContext
    
    // Flag to check if the DI is "empty", with no registrations
    let isEmpty: Bool
    
    init(isEmpty: Bool = false) {
        self.isEmpty = isEmpty
        navigationRegistry = NavigationRegistryFactoryImpl.make()
        navigationContext = NavigationContext(registry: navigationRegistry)

        super.init()

        // setUp the shared in this instance
        BTAppDI.shared = self

        if !isEmpty {
            registerAppNavigationModules()
            registerLogging()
            registerOnboarding()
        }
    }
    
    // Initialize the shared container from the app start
    static func setUp() {
        clear()
        shared = BTAppDI()
    }
    
    // Clean up the DI container (empty state)
    static func clear() {
        shared = DIContainer()
    }
    
    private func registerAppNavigationModules() {
        
        register(NavigationContext.self) { _ in self.navigationContext }
        register(AppNavigateToUC.self) { _ in
            AppNavigateToUCImpl(navigationHandler: self.navigationContext.navigationHandler)}
    }
    
    private func registerLogging() {
        register(BTLogger.self) { _ in logger(module: "MainApp") }
    }
    
    private func initOnboarding() {
        OnboardingInitializer.initialize()
    }  
    
    private func registerOnboarding() {
        register(ShouldShowOnboardingUC.self) { _ in ShouldShowOnboardingUCImpl()}
    }
}
