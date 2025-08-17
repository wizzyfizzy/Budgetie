//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import Onboarding
import OnboardingAPI
import DIModule
import XCTest

final class ShouldShowOnboardingUCTests: XCTestCase {
    private func arrange() -> (shouldShowOnboardingUC: ShouldShowOnboardingUC,
                               repo: OnboardingRepoMock) {
        
        let repo = OnboardingRepoMock()
        OnboardingDI.shared = DIContainer()
        OnboardingDI.shared.register(OnboardingRepo.self) { _ in repo }
        
        return (ShouldShowOnboardingUCImpl(),
                repo)
    }
    
    func testExecute_OnboardingIsNOTCompleted() {
        // Arrange
        let arrange = arrange()
        arrange.repo.stub.hasSeenOnboarding_Bool = { false }
        
        // Act
        let result = arrange.shouldShowOnboardingUC.execute()
        
        // Assert
        XCTAssertEqual(arrange.repo.verify.hasSeenOnboarding_Bool.count, 1)
        XCTAssertTrue(result)
    }
    
    func testExecute_OnboardingIsCompleted() {
        // Arrange
        let arrange = arrange()
        arrange.repo.stub.hasSeenOnboarding_Bool = { true }
        
        // Act
        let result = arrange.shouldShowOnboardingUC.execute()
        
        // Assert
        XCTAssertEqual(arrange.repo.verify.hasSeenOnboarding_Bool.count, 1)
        XCTAssertFalse(result)
    }
}
