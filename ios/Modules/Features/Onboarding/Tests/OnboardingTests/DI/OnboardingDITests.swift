//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import Onboarding
import AppLogging
import DIModule
import XCTest

final class OnboardingDITests: XCTestCase {

    func testSetShared() {
        OnboardingDI.shared = DIContainer()
        XCTAssertFalse(OnboardingDI.shared is OnboardingDI)
        _ = OnboardingDI.empty()
        XCTAssertTrue(OnboardingDI.shared is OnboardingDI)
    }
    
    func testIsEmpty() {
        let emptyDI = OnboardingDI.empty()
        XCTAssertTrue(emptyDI.isEmpty)

        let onboardingDI = OnboardingDI(dependencies: nil)
        XCTAssertFalse(onboardingDI.isEmpty)
    }
    
    func testOnboardingDIDependencies() {
        let dependencies = Dependencies.mock()
        let onboardingDI = OnboardingDI(dependencies: dependencies)
        
        XCTAssertNotNil(onboardingDI.resolve(BTLogger.self))
    }
}
