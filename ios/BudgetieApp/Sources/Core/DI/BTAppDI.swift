//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModule
import AppLogging
import AppNavigationAPI
import AppNavigation
import Auth
import BTMyBudget
import BTMyBudgetAPI
import BTSubscriptions
import BTSubscriptionsAPI
import BTTransactions
import BTTransactionsAPI
import BTProfile
import BTProfileAPI
import Onboarding

final class BTAppDI: DIContainer {
    // Shared singleton instance of type DIContainer
    static var shared = DIContainer()

    let navigationRegistry: NavigationRegistryProtocol
    private(set) var navigationContext: NavigationContext
    
    // Flag to check if the DI is "empty", with no registrations
    let isEmpty: Bool
    
    init(isEmpty: Bool = false) {
        self.isEmpty = isEmpty
        
        // Create a shared navigation registry for all modules
        navigationRegistry = NavigationRegistryFactoryImpl.make()
        navigationContext = NavigationContext(registry: navigationRegistry)

        super.init()

        // setUp the shared in this instance
        BTAppDI.shared = self

        if !isEmpty {
            registerAllViewsFromModules()
            registerAppNavigation()
            registerLogging()
            initOnboarding()
            registerOnboarding()
            initAuth()
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
    
    private func registerAllViewsFromModules() {
        // Register all module views to this shared registry for navigation
        OnboardingNavigationViewProvider.register(in: navigationRegistry)
        LoginNavigationViewProvider.register(in: navigationRegistry)
        
        // Register all module views to builder
        MyBudgetNavigationViewProvider.register(builder: MyBudgetViewBuilderImpl())
        SubscriptionsNavigationViewProvider.register(builder: SubscriptionsViewBuilderImpl())
        TransactionsNavigationViewProvider.register(builder: TransactionsViewBuilderImpl())
        ProfileNavigationViewProvider.register(builder: ProfileViewBuilderImpl())
    }
    
    private func registerAppNavigation() {
        register(NavigationContext.self) { _ in self.navigationContext }
        register(AppNavigateToUC.self) { _ in
            AppNavigateToUCImpl(navigationHandler: self.navigationContext.navigationHandler)}
    }
    
    private func registerLogging() {
        register(BTLogger.self) { _ in logger(module: "MainApp") }
    }
}
