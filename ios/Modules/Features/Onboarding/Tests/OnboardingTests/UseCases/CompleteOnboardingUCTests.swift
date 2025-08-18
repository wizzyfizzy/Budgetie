//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import Onboarding
import DIModule
import XCTest

final class CompleteOnboardingUCTests: XCTestCase {
    private func arrange() -> (completeOnboardingUC: CompleteOnboardingUC,
                               repo: OnboardingRepoMock) {
        
        let repo = OnboardingRepoMock()
        OnboardingDI.shared = DIContainer()
        OnboardingDI.shared.register(OnboardingRepo.self) { _ in repo }
        
        return (CompleteOnboardingUCImpl(),
                repo)
    }
    
    func testExecute() {
        // Arrange
        let arrange = arrange()
                
        // Act
        arrange.completeOnboardingUC.execute()
        
        // Assert execute() should call repo.completeOnboarding() exactly once
        XCTAssertEqual(arrange.repo.verify.completeOnboarding_Void.count, 1)
    }
}
