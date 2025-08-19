//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Combine
import AppLogging
import Foundation
import UIComponents

final class OnboardingVM: ObservableObject {
    @Published var currentStep: Int = 0

    @Injected private var completeOnboardingUC: CompleteOnboardingUC
    @Injected private var logger: BTLogger

    private var timerCancellable: AnyCancellable?
    private let fileName = "OnboardingVM"
    
    let onboardingSteps = [
        OnboardingStep(imageName: ImageKeys.imageOnboarding1, 
                       title: TextKeys.textOnboardingTitle1.localized(),
                       description: TextKeys.textOnboardingDescription1.localized()),
        OnboardingStep(imageName: ImageKeys.imageOnboarding2,
                       title: TextKeys.textOnboardingTitle2.localized(),
                       description: TextKeys.textOnboardingDescription2.localized()),
        OnboardingStep(imageName: ImageKeys.imageOnboarding3,
                       title: TextKeys.textOnboardingTitle3.localized(),
                       description: TextKeys.textOnboardingDescription3.localized())
    ]
    
    let textButtonSkip = TextKeys.textButtonSkip.localized()
    let textButtonNext = TextKeys.textButtonNext.localized()
    let textButtonGetStarted = TextKeys.textButtonGetStarted.localized()
    
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
