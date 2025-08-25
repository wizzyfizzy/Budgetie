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
        verify.loginEmailPassword_Async_UserData.append((email, password))
        guard let stub = stub.loginEmailPassword_Async_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((email, password))
    }
     func signup(name: String, email: String, password: String) async throws -> UserData {
        verify.signupNameEmailPassword_Async_UserData.append((name, email, password))
        guard let stub = stub.signupNameEmailPassword_Async_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((name, email, password))
    }
     func forgotPassword(email: String) async throws -> String {
        verify.forgotPasswordEmail_Async_String.append((email))
        guard let stub = stub.forgotPasswordEmail_Async_String else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((email))
    }
}
internal final class AuthAPISourceMock: AuthAPISource {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var signupNameEmailPassword_Async_UserData: (((String, String, String)) async throws -> UserData)?
        internal var loginEmailPassword_Async_UserData: (((String, String)) async throws -> UserData)?
        internal var forgotPasswordEmail_Async_String: ((String) async throws -> String)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var signupNameEmailPassword_Async_UserData: [(name: String, email: String, password: String)] = []
        internal var loginEmailPassword_Async_UserData: [(email: String, password: String)] = []
        internal var forgotPasswordEmail_Async_String: [String] = []
    }

    internal let stub = Stub()
    internal let verify = Verify()
     func signup(name: String, email: String, password: String) async throws -> UserData {
        verify.signupNameEmailPassword_Async_UserData.append((name, email, password))
        guard let stub = stub.signupNameEmailPassword_Async_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((name, email, password))
    }
     func login(email: String, password: String) async throws -> UserData {
        verify.loginEmailPassword_Async_UserData.append((email, password))
        guard let stub = stub.loginEmailPassword_Async_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((email, password))
    }
     func forgotPassword(email: String) async throws -> String {
        verify.forgotPasswordEmail_Async_String.append((email))
        guard let stub = stub.forgotPasswordEmail_Async_String else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((email))
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
        verify.executeEmail_Async_String.append((email))
        guard let stub = stub.executeEmail_Async_String else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((email))
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
        verify.executeEmailPassword_Async_UserData.append((email, password))
        guard let stub = stub.executeEmailPassword_Async_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((email, password))
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
        verify.executeNameEmailPassword_Async_UserData.append((name, email, password))
        guard let stub = stub.executeNameEmailPassword_Async_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return try await stub((name, email, password))
    }
}
internal final class UserSessionRepoMock: UserSessionRepo {

    internal init() {}

    // MARK: - Stub
    internal final class Stub {
        internal var saveUser_Void: ((UserData) throws -> Void)?
        internal var getUser_UserData: (() -> UserData?)?
        internal var getUserPublisher_Pub_UserData_Never: (() -> AnyPublisher<UserData?, Never>)?
    }

    // MARK: - Verify
    internal final class Verify {
        internal var saveUser_Void: [UserData] = []
        internal var getUser_UserData: [Void] = []
        internal var getUserPublisher_Pub_UserData_Never: [Void] = []
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
        guard let stub = stub.getUser_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return stub()
    }
     func getUserPublisher() -> AnyPublisher<UserData?, Never> {
        verify.getUserPublisher_Pub_UserData_Never.append(())
        guard let stub = stub.getUserPublisher_Pub_UserData_Never else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return stub()
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
        guard let stub = stub.loadUser_UserData else {
            fatalError("'\\(#function)' function called but not stubbed before. File: \\(#file)")
        }
        return stub()
    }
     func clear() {
        verify.clear_Void.append(())
    }
}
