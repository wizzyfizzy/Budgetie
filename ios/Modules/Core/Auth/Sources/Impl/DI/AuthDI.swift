//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModule
import AppLogging
import AuthAPI
import BTRestClientAPI
import Foundation
import UIComponents

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
        
        if let dep = dependencies {
            registerDependencies(dep)
        }
        registerSources()
        registerRepo()
        registerUceCases()
    }

    private func registerSources() {
        register(AuthAPISource.self) { _ in AuthAPISourceImpl()}
        register(UserSessionSource.self) { _ in UserSessionSourceImpl()}
    }

    private func registerRepo() {
        register(AuthAPIRepo.self) { _ in AuthAPIRepoImpl()}
        register(UserSessionRepo.self, instance: UserSessionRepoImpl())
    }
    
    private func registerUceCases() {
        register(LoginUserUC.self) { _ in LoginUserUCImpl()}
        register(ForgotPasswordUC.self) { _ in ForgotPasswordUCImpl()}
        register(SaveUserSessionUC.self) { _ in SaveUserSessionUCImpl()}
        register(SignUpUserUC.self) { _ in SignUpUserUCImpl()}
    }
    
    // MARK: Register Dependencies
    private func registerDependencies(_ dependencies: Dependencies) {
        register(BTLogger.self) { _ in logger(module: "Auth") }
        register(HTTPClient.self) { _ in dependencies.restClient() }
        register(SecureStore.self) { _ in dependencies.keyChain }
        register(UserDefaults.self) { _ in dependencies.userDefaults }
    }
}
