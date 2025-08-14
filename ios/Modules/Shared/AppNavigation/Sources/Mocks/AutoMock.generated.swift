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
@testable import AppNavigationAPI
public final class AppNavigateToUCMock: AppNavigateToUC {

    public init() {}

    // MARK: - Stub
    public final class Stub {
    }

    // MARK: - Verify
    public final class Verify {
        public var executeDataType_Void: [(data: NavigationData, type: NavigationType)] = []
    }

    public let stub = Stub()
    public let verify = Verify()
    public func execute(data: NavigationData, type: NavigationType) {
        verify.executeDataType_Void.append((data, type))
    }
}
