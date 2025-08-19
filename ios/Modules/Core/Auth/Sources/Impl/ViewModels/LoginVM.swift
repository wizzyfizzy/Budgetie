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
    @Published var rememberMe: Bool = false
    // State
    @Published var isSecure: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var emailError: String?
    private var passwordError: String?
    
    private var cancellables = Set<AnyCancellable>()
   
    public init() { }

    var isFormValid: Bool {
        validateForm()
        return errorMessage == nil
    }
    
    func onAppear() {
        if let last = UserDefaults.standard.string(forKey: "lastEmail"),
           email.isEmpty {
            email = last
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
        emailError = !email.isValidEmail ? "Invalid email format." : nil
        if errorMessage != nil { validateForm() }
     }
    
    private func validatePassword() {
        passwordError = password.count < 6 ? "Password should have at least 6 characters." : nil
        if errorMessage != nil { validateForm() }
     }
    
    // TODO: Replace with real API.
    func signIn() -> AnyPublisher<String, Error> {
        isLoading = true
        errorMessage = nil
        
        // Simulate network delay + validation
        return Just((email, password))
            .delay(for: .milliseconds(900), scheduler: RunLoop.main)
            .tryMap { email, pwd in
                guard email.lowercased().hasSuffix("@example.com") || email.lowercased().hasSuffix("@gmail.com") else {
                    throw SignInError.invalidCredentials
                }
                guard pwd.count >= 6 else { throw SignInError.invalidCredentials }
                
                let userID = "user_\(abs(email.hashValue))" // mock
                //save rememberMe
                if self.rememberMe {
                    let service = "com.budgetie.auth"
                    // example: mock token
                    let token = "mock_token_for_\(userID)"
                    try? Keychain.save(service: service, account: "authToken", data: Data(token.utf8))

                    // store email για autofill
                    UserDefaults.standard.set(self.email, forKey: "lastEmail")
                } else {
                    try? Keychain.delete(service: "com.budgetie.auth", account: "authToken")
                    UserDefaults.standard.removeObject(forKey: "lastEmail")
                }
                return userID
            }
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .eraseToAnyPublisher()
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
