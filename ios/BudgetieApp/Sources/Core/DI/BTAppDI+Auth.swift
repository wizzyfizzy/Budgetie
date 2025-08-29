//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AuthAPI
import Auth
import AppLogging
import BTRestClient
import UIComponents
import Foundation

extension BTAppDI {
    func initAuth() {
        let dependencies = Auth.Dependencies(logger: { logger(module: "Auth") },
                                             restClient: { self.resolve() },
                                             keyChain: KeychainSecureStore(),
                                             userDefaults: UserDefaults.standard)
        
        AuthInitializer.initialize(dependencies: dependencies)
    }
    
    func registerAuth() {
        register(GetUserSessionUC.self) { _ in GetUserSessionUCImpl() }
        register(IsLoggedInUC.self) { _ in IsLoggedInUCImpl() }
        register(LogoutUserUC.self) { _ in LogoutUserUCImpl() }
    }
}
