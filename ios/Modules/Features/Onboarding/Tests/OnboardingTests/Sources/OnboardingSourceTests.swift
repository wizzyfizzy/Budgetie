//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import Onboarding
import UIComponents
import XCTest

final class OnboardingSourceTests: XCTestCase {
    private func arrange() -> (source: OnboardingSource,
                               userDefaults: UserDefaults) {
        let suiteName = "OnboardingSourceTests"

        let userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
        userDefaults.removePersistentDomain(forName: suiteName)
        let source = OnboardingSourceImpl(userDefaults: userDefaults)

        return (source,
                userDefaults)
    }
    
    func testHasSeenOnboarding_DefaultFalse() {
        // Arrange
        let arrange = arrange()
        
        // Assert
        XCTAssertFalse(arrange.userDefaults.isOnboardingCompleted)
        XCTAssertFalse(arrange.source.hasSeenOnboarding())
    }
    
    func testHasSeenOnboarding_SetToTrue() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.source.completeOnboarding()
        
        // Assert
        XCTAssertTrue(arrange.userDefaults.isOnboardingCompleted)
        XCTAssertTrue(arrange.source.hasSeenOnboarding())
    }
    
    func testCompleteOnboarding_overridesExistingValue() {
        // Arrange
        let arrange = arrange()
        arrange.userDefaults.isOnboardingCompleted = false
        XCTAssertFalse(arrange.source.hasSeenOnboarding())
        
        // Act
        arrange.source.completeOnboarding()
        
        XCTAssertTrue(arrange.userDefaults.isOnboardingCompleted)
        XCTAssertTrue(arrange.source.hasSeenOnboarding())
    }
}
