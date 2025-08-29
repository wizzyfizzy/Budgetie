//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModule
import AppLogging
import AuthAPI
import AppNavigationAPI

final class BTProfileDI: DIContainer {
    static var shared = DIContainer()
    let isEmpty: Bool
    
    static func empty() -> BTProfileDI {
        BTProfileDI(empty: true, dependencies: nil)
    }

    init(empty: Bool = false,
         dependencies: Dependencies?) {
        isEmpty = empty
        super.init()

        BTProfileDI.shared = self
        guard !isEmpty else { return }

        registerRepo()
        registerUceCases()
        
        if let dep = dependencies {
            registerDependencies(dep)
        }
    }

    private func registerRepo() {
        register(ProfileSettingsRepo.self) { _ in ProfileSettingsRepoImpl() }
    }
    
    private func registerUceCases() {
        register(GetProfileSettingsUC.self) { _ in GetProfileSettingsUCImpl() }
        register(UpdateDarkModeUC.self) { _ in UpdateDarkModeUCImpl() }
        register(UpdateLanguageUC.self) { _ in UpdateLanguageUCImpl() }
        register(UpdateNotificationsUC.self) { _ in UpdateNotificationsUCImpl() }
        register(UpdateReminderTimeUC.self) { _ in UpdateReminderTimeUCImpl() }
        register(TrackEventUC.self) { _ in TrackEventUCImpl() }
        register(TrackViewUC.self) { _ in TrackViewUCImpl() }
    }
    
    // MARK: Register Dependencies
    private func registerDependencies(_ dependencies: Dependencies) {
        register(BTLogger.self) { _ in logger(module: "Auth") }
        register(IsLoggedInUC.self) { _ in dependencies.auth.isLoggedInUC() }
        register(GetUserSessionUC.self) { _ in dependencies.auth.getUserSessionUC() }
        register(LogoutUserUC.self) { _ in dependencies.auth.logoutUserUC() }
        register(AppNavigateToUC.self) { _ in dependencies.navigation.appNavigateToUC() }
    }
}
