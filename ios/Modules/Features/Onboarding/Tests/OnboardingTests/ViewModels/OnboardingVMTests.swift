//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import Onboarding
import AppLogging
import AppLoggingMocks
import DIModule
import XCTest

final class OnboardingVMTests: XCTestCase {
    private func arrange() -> (onboardingVM: OnboardingVM,
                               completeOnboardingUC: CompleteOnboardingUCMock,
                               logger: BTLoggerMock) {
        
        let completeOnboardingUC = CompleteOnboardingUCMock()
        let logger = BTLoggerMock()
        OnboardingDI.shared = DIContainer()
        OnboardingDI.shared.register(CompleteOnboardingUC.self) { _ in completeOnboardingUC }
        OnboardingDI.shared.register(BTLogger.self) { _ in logger }
        
        return (OnboardingVM(),
                completeOnboardingUC,
                logger)
    }
    
    func testIsLastStep() {
        // Arrange
        let arrange = arrange()
                
        // Act
        arrange.onboardingVM.currentStep = arrange.onboardingVM.onboardingSteps.count - 1
        
        // Assert
        XCTAssertTrue(arrange.onboardingVM.isLastStep)
    }
    
    func testIsNotLastStep() {
        // Arrange
        let arrange = arrange()
                
        // Act
        arrange.onboardingVM.currentStep = arrange.onboardingVM.onboardingSteps.count - 2
        
        // Assert
        XCTAssertFalse(arrange.onboardingVM.isLastStep)
    }
    
    func testSkipOnboarding() {
        // Arrange
        let arrange = arrange()
                
        // Act
        arrange.onboardingVM.skipOnboarding()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
    }
    
    func testCompleteOnboarding() {
        // Arrange
        let arrange = arrange()
                
        // Act
        arrange.onboardingVM.completeOnboarding()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        XCTAssertEqual(arrange.completeOnboardingUC.verify.execute_Void.count, 1)
    }
    
    func testNextStep() {
        // Arrange
        let arrange = arrange()
        let prevStep = arrange.onboardingVM.currentStep
                
        // Act
        arrange.onboardingVM.nextStep()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
        XCTAssertEqual(arrange.onboardingVM.currentStep, prevStep + 1)
    }
    
    func testTrackView() {
        // Arrange
        let arrange = arrange()
        
        // Act
        arrange.onboardingVM.trackView()
        
        // Assert
        XCTAssertEqual(arrange.logger.verify.logFileName_Void.count, 1)
    }
    
    func testStartAutoScroll() {
        // Arrange
        let exp = expectation(description: "Wait for timer")
        let arrange = arrange()
        arrange.onboardingVM.currentStep = 0
        
        // Act
        arrange.onboardingVM.startAutoScroll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            XCTAssertEqual(arrange.onboardingVM.currentStep, 1)
            arrange.onboardingVM.stopTimer()
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
}
