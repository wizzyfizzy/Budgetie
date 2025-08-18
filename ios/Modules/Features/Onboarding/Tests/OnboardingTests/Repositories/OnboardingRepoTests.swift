//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import Onboarding
import DIModule
import XCTest

final class OnboardingRepoTests: XCTestCase {
    private func arrange() -> (repo: OnboardingRepo,
                               source: OnboardingSourceMock) {
        
        let source = OnboardingSourceMock()
        OnboardingDI.shared = DIContainer()
        OnboardingDI.shared.register(OnboardingSource.self) { _ in source }

        return (OnboardingRepoImpl(),
                source)
    }
    
    func testHasSeenOnboarding() {
        // Arrange
        let arrange = arrange()
        arrange.source.stub.hasSeenOnboarding_Bool = { false }
        
        // Act
        let result = arrange.repo.hasSeenOnboarding()
        // Assert
        XCTAssertFalse(result)
    
        arrange.source.stub.hasSeenOnboarding_Bool = { true }
        // Act
        let result2 = arrange.repo.hasSeenOnboarding()
        // Assert
        XCTAssertTrue(result2)
    }
    
    func testCompleteOnboarding() {
        // Arrange
        let arrange = arrange()
        XCTAssertEqual(arrange.source.verify.completeOnboarding_Void.count, 0)

        // Act
        arrange.repo.completeOnboarding()
        
        // Assert
        XCTAssertEqual(arrange.source.verify.completeOnboarding_Void.count, 1)
    }
    
}
