//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging
import AuthAPI
import AppNavigationAPI

public struct Dependencies {
    let logger: () -> BTLogger
    let auth: Auth
    let navigation: Navigation
    
    public struct Auth {
        let isLoggedInUC: () -> IsLoggedInUC
        let getUserSessionUC: () -> GetUserSessionUC
        let logoutUserUC: () -> LogoutUserUC
        
        public init(isLoggedInUC: @escaping () -> IsLoggedInUC,
                    getUserSessionUC: @escaping () -> GetUserSessionUC,
                    logoutUserUC: @escaping () -> LogoutUserUC) {
            self.isLoggedInUC = isLoggedInUC
            self.getUserSessionUC = getUserSessionUC
            self.logoutUserUC = logoutUserUC
        }
    }  
    
    public struct Navigation {
        let appNavigateToUC: () -> AppNavigateToUC
        
        public init(appNavigateToUC: @escaping () -> AppNavigateToUC) {
            self.appNavigateToUC = appNavigateToUC
        }
    }
    
    public init(logger: @escaping () -> BTLogger,
                auth: Auth,
                navigation: Navigation) {
        self.logger = logger
        self.auth = auth
        self.navigation = navigation
    }
}
