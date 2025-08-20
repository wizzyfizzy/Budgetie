//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import Combine
import UIComponents

final class LoginVM: ObservableObject {
    // MARK: - Inputs
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var rememberMe: Bool
    
    // MARK: - State
    @Published var isSecure: Bool = true
    @Published var isLoading: Bool = false
    @Published var isLoginButtonEnabled: Bool = true
    @Published private(set) var errorMessage: String?
    
    // MARK: - Dependencies
    private let userDefaults: UserDefaults
    private let keychainService = "com.budgetie.auth"
    private var cancellables = Set<AnyCancellable>()
    
    //    private var emailError: String?
    //    private var passwordError: String?
    
    // MARK: - Initialization
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.rememberMe = userDefaults.rememberMe
        setupBindings()
    }
    
    // MARK: - Computed Properties
    var isFormValid: Bool {
        return errorMessage == nil
    }
    
    // MARK: - Public
    func onAppear() {
        if userDefaults.rememberMe,
           let savedEmail = userDefaults.lastEmail {
            email = savedEmail
            rememberMe = true
        }
    }
    
    // TODO: Replace with real API.
    func signIn() -> AnyPublisher<String, Error> {
        isLoading = true
        errorMessage = nil
        let userId = "user_\(abs(email.hashValue))" // mock
        self.saveIfRememberMe(userId: userId)
        
        // Simulate network delay + validation
        return Just((email, password))
            .delay(for: .milliseconds(900), scheduler: RunLoop.main)
            .tryMap { [weak self] email, pwd in
                guard
                    let self, email.lowercased().hasSuffix("@example.com") || email.lowercased().hasSuffix("@gmail.com") else {
                    throw SignInError.invalidCredentials
                }
                guard pwd.count >= 6 else { throw SignInError.invalidCredentials }
                
                let userId = "user_\(abs(email.hashValue))" // mock
                self.saveIfRememberMe(userId: userId)
                return userId
            }
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: - Errors
    enum SignInError: LocalizedError {
        case invalidCredentials
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return TextKeys.textAuthErrorWrongCredentials.localized()
            }
        }
    }
}

// MARK: - Private
private extension LoginVM {
    
    private func setupBindings() {
        // Combine email + password errors
        Publishers.CombineLatest($email, $password)
            .map { email, password -> String? in
                var errors: [String] = []
                if  email.isEmpty {
                    errors.append("Please fill in your email.")
                } else if !email.isValidEmail {
                    errors.append("Invalid email format.")
                }
                if password.count < 6 { errors.append("Password should have at least 6 characters.") }
                return errors.isEmpty ? nil : errors.joined(separator: "\n")
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] combinedError in
                guard let self else { return }
                self.errorMessage = combinedError
                self.isLoginButtonEnabled = combinedError == nil
            }
            .store(in: &cancellables)
    }
    
    private func saveIfRememberMe(userId: String) {
        if rememberMe {
            // example: mock token
            let token = "mock_token_for_\(userId)"
            
            try? Keychain.save(
                service: keychainService,
                account: email,
                data: Data(token.utf8))
            userDefaults.lastEmail = email
            userDefaults.rememberMe = true
        } else {
            try? Keychain.delete(
                service: keychainService,
                account: email)
            userDefaults.lastEmail = nil
            userDefaults.rememberMe = false
        }
    }
}
