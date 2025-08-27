//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Auth
import AppLogging
import BTProfile
import BTProfileAPI

extension BTAppDI {
    func initBTProfile() {
        let dependencies = BTProfile.Dependencies(logger: { logger(module: "BTProfile") },
                                             auth: getAuthDependencies())
        BTProfileInitializer.initialize(dependencies: dependencies)
    }
    
    private func getAuthDependencies() -> BTProfile.Dependencies.Auth {
            BTProfile.Dependencies.Auth(isLoggedInUC: { Auth.IsLoggedInUCImpl() },
                                        getUserSessionUC: { Auth.GetUserSessionUCImpl() },
                                        logoutUserUC: { Auth.LogoutUserUCImpl() })
    }
    
}
