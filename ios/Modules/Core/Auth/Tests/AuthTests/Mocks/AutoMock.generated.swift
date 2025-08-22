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
internal final class AuthAPIRepoMock: AuthAPIRepo {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var loginEmailPassword_Async_UserData: (((String, String)) async throws -> UserData)?
        internal var signupNameEmailPassword_Async_UserData: (((String, String, String)) async throws -> UserData)?
        internal var forgotPasswordEmail_Async_String: ((String) async throws -> String)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var loginEmailPassword_Async_UserData: [(email: String, password: String)] = []
        internal var signupNameEmailPassword_Async_UserData: [(name: String, email: String, password: String)] = []
        internal var forgotPasswordEmail_Async_String: [String] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func login(email: String, password: String) async throws -> UserData {
        await verify.loginEmailPassword_Async_UserData.append((email, password))
        if let stub = stub.loginEmailPassword_Async_UserData {
            try await stub((email, password))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
    }
     func signup(name: String, email: String, password: String) async throws -> UserData {
        await verify.signupNameEmailPassword_Async_UserData.append((name, email, password))
        if let stub = stub.signupNameEmailPassword_Async_UserData {
            try await stub((name, email, password))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
    }
     func forgotPassword(email: String) async throws -> String {
        await verify.forgotPasswordEmail_Async_String.append((email))
        if let stub = stub.forgotPasswordEmail_Async_String {
            try await stub((email))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
    }
}
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
internal final class ForgotPasswordUCMock: ForgotPasswordUC {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var executeEmail_Async_String: ((String) async throws -> String)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var executeEmail_Async_String: [String] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func execute(email: String) async throws -> String {
        await verify.executeEmail_Async_String.append((email))
        if let stub = stub.executeEmail_Async_String {
            try await stub((email))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
    }
}
internal final class LoginUserUCMock: LoginUserUC {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var executeEmailPassword_Async_UserData: (((String, String)) async throws -> UserData)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var executeEmailPassword_Async_UserData: [(email: String, password: String)] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func execute(email: String, password: String) async throws -> UserData {
        await verify.executeEmailPassword_Async_UserData.append((email, password))
        if let stub = stub.executeEmailPassword_Async_UserData {
            try await stub((email, password))
        } else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
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
internal final class SignUpUserUCMock: SignUpUserUC {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var executeNameEmailPassword_Async_UserData: (((String, String, String)) async throws -> UserData)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var executeNameEmailPassword_Async_UserData: [(name: String, email: String, password: String)] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func execute(name: String, email: String, password: String) async throws -> UserData {
        await verify.executeNameEmailPassword_Async_UserData.append((name, email, password))
        if let stub = stub.executeNameEmailPassword_Async_UserData {
            try await stub((name, email, password))
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
