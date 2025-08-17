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

    private var timerCancellable: AnyCancellable?
    private let fileName = "OnboardingVM"
    
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
        trackAction(TrackingAction.tapSkip)
    }
    
    func completeOnboarding() {
        trackAction(TrackingAction.tapCompleted)
        completeOnboardingUC.execute()
    }
    
    func nextStep() {
        trackAction(TrackingAction.tapNext)
        currentStep += 1
    }
    
    func trackView() {
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingView.onboardingScreen)")
    }
    
    func startAutoScroll() {
        timerCancellable = Timer.publish(every: 4.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self, !self.isLastStep else { return }
                self.trackAction(TrackingAction.timer)
                self.currentStep += 1
            }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    private func trackAction(_ action: TrackingAction) {
        logger.log(.debug, fileName: fileName, "Tracking Action: \(action) for \(TrackingValue.onboardingStep): \(currentStep)")
    }
}
