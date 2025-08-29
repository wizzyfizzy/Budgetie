//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging
import BTProfile
import BTProfileAPI

extension BTAppDI {
    func initBTProfile() {
        let dependencies = BTProfile.Dependencies(logger: { logger(module: "BTProfile") },
                                             auth: getAuthDependencies(),
                                             navigation: getNavigationDependencies())
        BTProfileInitializer.initialize(dependencies: dependencies)
    }
    
    private func getAuthDependencies() -> BTProfile.Dependencies.Auth {
        BTProfile.Dependencies.Auth(isLoggedInUC: { self.resolve() },
                                    getUserSessionUC: { self.resolve() },
                                    logoutUserUC: { self.resolve() })
    }
    private func getNavigationDependencies() -> BTProfile.Dependencies.Navigation {
        BTProfile.Dependencies.Navigation(appNavigateToUC: { self.resolve() })
    }
}
