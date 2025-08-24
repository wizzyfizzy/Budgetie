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
@testable import OnboardingAPI
public final class ShouldShowOnboardingUCMock: ShouldShowOnboardingUC {

    public init() {}

    // MARK: - Stub
    public final class Stub {
        public var execute_Bool: (() -> Bool)?
    }

    // MARK: - Verify
    public final class Verify {
        public var execute_Bool: [Void] = []
    }

    public let stub = Stub()
    public let verify = Verify()
    public func execute() -> Bool {
        verify.execute_Bool.append(())
        guard let stub = stub.execute_Bool else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return stub()
    }
}
