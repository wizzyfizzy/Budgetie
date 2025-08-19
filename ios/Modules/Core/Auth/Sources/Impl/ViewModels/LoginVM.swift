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
    // Inputs
    @Published var email: String = "" {
        didSet { validateEmail() }
    }
    @Published var password: String = "" {
        didSet { validatePassword() }
    }
    @Published var rememberMe: Bool = UserDefaults.rememberMe
    // State
    @Published var isSecure: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var emailError: String?
    private var passwordError: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let service = "com.budgetie.auth"
    
    public init() { }
    
    var isFormValid: Bool {
        validateForm()
        return errorMessage == nil
    }
    
    func onAppear() {
        if UserDefaults.rememberMe,
           let savedEmail = UserDefaults.lastEmail {
            email = savedEmail
            rememberMe = true
        }

    }
    
    func validateForm() {
        validateEmail()
        validatePassword()
        var errors: [String] = []
        
        if let emailError { errors.append(emailError) }
        if let passwordError { errors.append(passwordError) }
        
        errorMessage = errors.isEmpty ? nil : errors.joined(separator: "\n")
    }
    
    private func validateEmail() {
        errorMessage = nil
        emailError = !email.isValidEmail ? "Invalid email format." : nil
    }
    
    private func validatePassword() {
        errorMessage = nil
        passwordError = password.count < 6 ? "Password should have at least 6 characters." : nil
    }
    
    // TODO: Replace with real API.
    func signIn() -> AnyPublisher<String, Error> {
        isLoading = true
        errorMessage = nil
        let userId = "user_\(abs(email.hashValue))" // mock
        self.saveBasedOnRememberMeToggle(userId: userId)
        
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
                self.saveBasedOnRememberMeToggle(userId: userId)
                return userId
            }
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .eraseToAnyPublisher()
    }
    
    private func saveBasedOnRememberMeToggle(userId: String) {
        if rememberMe {
            // example: mock token
            let token = "mock_token_for_\(userId)"

            try? Keychain.save(
                service: service,
                account: email,
                data: Data(token.utf8))
            UserDefaults.lastEmail = email
            UserDefaults.rememberMe = true
        } else {
            try? Keychain.delete(
                service: email,
                account: email)
            UserDefaults.lastEmail = nil
            UserDefaults.rememberMe = false
        }
    }

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
