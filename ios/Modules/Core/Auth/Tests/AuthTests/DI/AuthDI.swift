//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import Auth
import AppLogging
import DIModule
import XCTest
import BTRestClientAPI
import UIComponents

extension AuthDI {
    static func empty() -> AuthDI {
        AuthDI(empty: true,
               dependencies: Dependencies.mock())
    }
}

final class AuthDITests: XCTestCase {
    func testSetShared() {
        AuthDI.shared = DIContainer()
        XCTAssertFalse(AuthDI.shared is AuthDI)
        _ = AuthDI.empty()
        XCTAssertTrue(AuthDI.shared is AuthDI)
    }
    
    func testIsEmpty() {
        let emptyDI = AuthDI.empty()
        XCTAssertTrue(emptyDI.isEmpty)

        let authDI = AuthDI(empty: false,
                            dependencies: Dependencies.mock())
        XCTAssertFalse(authDI.isEmpty)
    }
    
    func testAuthDIDependencies() {
        let dependencies = Dependencies.mock()
        let authDI = AuthDI(dependencies: dependencies)
        
        XCTAssertNotNil(authDI.resolve(BTLogger.self))
        XCTAssertNotNil(authDI.resolve(HTTPClient.self))
        XCTAssertNotNil(authDI.resolve(SecureStore.self))
        XCTAssertNotNil(authDI.resolve(UserDefaults.self))

        XCTAssertNotNil(authDI.resolve(UserSessionSource.self))
        XCTAssertNotNil(authDI.resolve(AuthAPISource.self))
        
        XCTAssertNotNil(authDI.resolve(UserSessionRepo.self))
        XCTAssertNotNil(authDI.resolve(AuthAPIRepo.self))

        XCTAssertNotNil(authDI.resolve(SaveUserSessionUC.self))
        XCTAssertNotNil(authDI.resolve(LoginUserUC.self))
        XCTAssertNotNil(authDI.resolve(SignUpUserUC.self))
        XCTAssertNotNil(authDI.resolve(ForgotPasswordUC.self))
    }
}
