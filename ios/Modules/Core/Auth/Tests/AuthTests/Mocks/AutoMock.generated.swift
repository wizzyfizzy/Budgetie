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
import AuthAPI
@testable import Auth
internal final class ClearUserSessionUCMock: ClearUserSessionUC {

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
internal final class SaveUserSessionUCMock: SaveUserSessionUC {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var executeUser_Void: ((UserData) throws -> Void)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var executeUser_Void: [UserData] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func execute(user: UserData) throws {
        verify.executeUser_Void.append((user))
        if let stub = stub.executeUser_Void {
            try stub((user))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
    }
}
internal final class UserSessionRepoMock: UserSessionRepo {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var saveUser_Void: ((UserData) throws -> Void)?
        internal var getUser_UserData: (() -> UserData?)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var saveUser_Void: [UserData] = []
        internal var getUser_UserData: [Void] = []
        internal var clearUser_Void: [Void] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func saveUser(_ user: UserData) throws {
        verify.saveUser_Void.append((user))
        if let stub = stub.saveUser_Void {
            try stub((user))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
    }
     func getUser() -> UserData? {
        verify.getUser_UserData.append(())
        guard let value = stub.getUser_UserData?() else {
             fatalError( "'\(#function)' function called but not stubbed before. File: \(#file)")
         }
        return value
    }
     func clearUser() {
        verify.clearUser_Void.append(())
    }
}
internal final class UserSessionSourceMock: UserSessionSource {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var saveUser_Void: ((UserData) throws -> Void)?
        internal var loadUser_UserData: (() -> UserData?)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var saveUser_Void: [UserData] = []
        internal var loadUser_UserData: [Void] = []
        internal var clear_Void: [Void] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func save(user: UserData) throws {
        verify.saveUser_Void.append((user))
        if let stub = stub.saveUser_Void {
            try stub((user))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
    }
     func loadUser() -> UserData? {
        verify.loadUser_UserData.append(())
        guard let value = stub.loadUser_UserData?() else {
             fatalError( "'\(#function)' function called but not stubbed before. File: \(#file)")
         }
        return value
    }
     func clear() {
        verify.clear_Void.append(())
    }
}
