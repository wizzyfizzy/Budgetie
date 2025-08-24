//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI
import Auth
import AppLogging

extension BTAppDI {
    func initAuth() {
        let dependencies = Auth.Dependencies(logger: { logger(module: "Auth") })
        AuthInitializer.initialize(dependencies: dependencies)
    }
    
    func registerAuth() {
        register(GetUserSessionUC.self) { _ in GetUserSessionUCImpl() }
        register(IsLoggedInUC.self) { _ in IsLoggedInUCImpl() }
    }
}
