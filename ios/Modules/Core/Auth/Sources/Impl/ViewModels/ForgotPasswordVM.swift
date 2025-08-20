//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

final class RegisterVM: ObservableObject {
    
}

final class ForgotPasswordVM: ObservableObject {
    // Inputs
    @Published var email: String = "" {
        didSet { validateEmail() }
    }
    @Published var password: String = "" {
        didSet { validatePassword() }
    }

    // State
    @Published var isSecure: Bool = true
    @Published var isLoading: Bool = false
    @Published var buttonShouldBeEnabled: Bool = true
    @Published var errorMessage: String?
    
    private var emailError: String?
    private var passwordError: String?

    private func validateEmail() {
        errorMessage = nil
        emailError = !email.isValidEmail ? "Invalid email format." : nil
        validateForm()
    }
    
    private func validatePassword() {
        errorMessage = nil
        passwordError = password.count < 6 ? "Password should have at least 6 characters." : nil
        validateForm()
    }
    
    private func validateForm() {
        var errors: [String] = []
        
        if let emailError { errors.append(emailError) }
        if let passwordError { errors.append(passwordError) }
        
        errorMessage = errors.isEmpty ? nil : errors.joined(separator: "\n")
        buttonShouldBeEnabled = errorMessage == nil
    }
}
