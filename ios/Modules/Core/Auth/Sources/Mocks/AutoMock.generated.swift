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
@testable import AuthAPI
public final class GetUserSessionUCMock: GetUserSessionUC {

    public init() {}

    // MARK: - Stub
    public final class Stub {
        public var execute_UserData: (() -> UserData?)?
    }

    // MARK: - Verify
    public final class Verify {
        public var execute_UserData: [Void] = []
    }

    public let stub = Stub()
    public let verify = Verify()
    public func execute() -> UserData? {
        verify.execute_UserData.append(())
        guard let value = stub.execute_UserData?() else {
             fatalError( "'\(#function)' function called but not stubbed before. File: \(#file)")
         }
        return value
    }
}
