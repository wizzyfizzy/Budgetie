//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModule
import AppLogging
import AuthAPI

final class AuthDI: DIContainer {
    static var shared = DIContainer()
    let isEmpty: Bool
    
    static func empty() -> AuthDI {
        AuthDI(empty: true, dependencies: nil)
    }

    init(empty: Bool = false,
         dependencies: Dependencies?) {
        isEmpty = empty
        super.init()

        AuthDI.shared = self
        guard !isEmpty else { return }

        registerSources()
        registerRepo()
        registerUceCases()
        
        if dependencies != nil {
            registerLogging()
        }

    }

    private func registerSources() {
        register(UserSessionSource.self) { _ in UserSessionSourceImpl()}
        register(AuthAPISource.self) { _ in AuthAPISourceImpl()}
    }

    private func registerRepo() {
        register(UserSessionRepo.self) { _ in UserSessionRepoImpl()}
        register(AuthAPIRepo.self) { _ in AuthAPIRepoImpl()}
    }
    
    private func registerUceCases() {
        register(ClearUserSessionUC.self) { _ in ClearUserSessionUCImpl()}
        register(SaveUserSessionUC.self) { _ in SaveUserSessionUCImpl()}
        register(LoginUserUC.self) { _ in LoginUserUCImpl()}
    }
    
    // MARK: Register Dependencies
    private func registerLogging() {
        register(BTLogger.self) { _ in logger(module: "Auth") }
    }
}
