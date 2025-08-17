//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Combine
import AppLogging
import Foundation

public final class OnboardingVM: ObservableObject {
    @Published var currentStep: Int = 0

    @Injected private var completeOnboardingUC: CompleteOnboardingUC
    @Injected private var logger: BTLogger

    private var timer: Timer?

    public init() { }
    
    let onboardingSteps = [
        OnboardingStep(imageName: ImageKeys.imageOnboarding1, 
                       title: "Welcome to Budgetie",
                       description: "Monitor your monthly expenses. Master your money! Budget it with style!"),
        OnboardingStep(imageName: ImageKeys.imageOnboarding2,
                       title: "Track your subscriptions",
                       description: "Use Swift Charts to analyze your spending patterns."),
        OnboardingStep(imageName: ImageKeys.imageOnboarding3, 
                       title: "Learn and improve your budget",
                       description: "Discover smarter ways to manage your budget with AI-powered tips.")
    ]
    
    var isLastStep: Bool {
        currentStep == onboardingSteps.count - 1
    }
    
    func skipOnboarding() {
        logger.log(.debug, fileName: "OnboardingVM", "Tracking Action: \(TrackingAction.tapSkip) for \(TrackingValue.onboardingStep): \(currentStep)")
    }
    
    func completeOnboarding() {
        logger.log(.debug, fileName: "OnboardingVM", "Tracking Action: \(TrackingAction.tapCompleted)")
        completeOnboardingUC.execute()
    }
    
    func nextStep() {
        logger.log(.debug, fileName: "OnboardingVM", "Tracking Action: \(TrackingAction.tapNext) for \(TrackingValue.onboardingStep): \(currentStep)")

        currentStep += 1
    }
    
    func trackView() {
        logger.log(.debug, fileName: "OnboardingVM", "TrackingView: \(TrackingView.onboardingScreen)")
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] _ in
            guard let self else { return }
            if !isLastStep {
                logger.log(.debug, fileName: "OnboardingVM", "Tracking Action: \(TrackingAction.timer) for \(TrackingValue.onboardingStep): \(currentStep)")
                currentStep += 1
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
