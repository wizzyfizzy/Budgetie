// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
// swiftlint:disable all
// swiftformat:disable all
import Foundation
import Combine
import OnboardingAPI
@testable import Onboarding
internal final class CompleteOnboardingUCMock: CompleteOnboardingUC {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
    }

    // MARK: - Verify
    internal final class Verify {
        internal var execute_Void: [Void] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func execute() {
        verify.execute_Void.append(())
    }
}
internal final class OnboardingRepoMock: OnboardingRepo {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
            internal var hasSeenOnboarding_Bool: (() -> Bool)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var hasSeenOnboarding_Bool: [Void] = []
        internal var completeOnboarding_Void: [Void] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func hasSeenOnboarding() -> Bool {
        verify.hasSeenOnboarding_Bool.append(())
        guard let value = stub.hasSeenOnboarding_Bool?() else {
             fatalError( "'\(#function)' function called but not stubbed before. File: \(#file)")
         }
        return value
    }
     func completeOnboarding() {
        verify.completeOnboarding_Void.append(())
    }
}
internal final class OnboardingSourceMock: OnboardingSource {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
            internal var hasSeenOnboarding_Bool: (() -> Bool)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var hasSeenOnboarding_Bool: [Void] = []
        internal var completeOnboarding_Void: [Void] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func hasSeenOnboarding() -> Bool {
        verify.hasSeenOnboarding_Bool.append(())
        guard let value = stub.hasSeenOnboarding_Bool?() else {
             fatalError( "'\(#function)' function called but not stubbed before. File: \(#file)")
         }
        return value
    }
     func completeOnboarding() {
        verify.completeOnboarding_Void.append(())
    }
}
