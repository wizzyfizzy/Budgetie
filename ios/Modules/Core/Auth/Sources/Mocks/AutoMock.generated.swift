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
        public var executePublisher_Pub_UserData_Never: (() -> AnyPublisher<UserData?, Never>)?
    }

    // MARK: - Verify
    public final class Verify {
        public var execute_UserData: [Void] = []
        public var executePublisher_Pub_UserData_Never: [Void] = []
    }

    public let stub = Stub()
    public let verify = Verify()
    public func execute() -> UserData? {
        verify.execute_UserData.append(())
        guard let stub = stub.execute_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return stub()
    }
    public func executePublisher() -> AnyPublisher<UserData?, Never> {
        verify.executePublisher_Pub_UserData_Never.append(())
        guard let stub = stub.executePublisher_Pub_UserData_Never else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return stub()
    }
}
public final class IsLoggedInUCMock: IsLoggedInUC {

    public init() {}

    // MARK: - Stub
    public final class Stub {
        public var execute_Bool: (() -> Bool)?
        public var executePublisher_Pub_Bool_Never: (() -> AnyPublisher<Bool, Never>)?
    }

    // MARK: - Verify
    public final class Verify {
        public var execute_Bool: [Void] = []
        public var executePublisher_Pub_Bool_Never: [Void] = []
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
    public func executePublisher() -> AnyPublisher<Bool, Never> {
        verify.executePublisher_Pub_Bool_Never.append(())
        guard let stub = stub.executePublisher_Pub_Bool_Never else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return stub()
    }
}
