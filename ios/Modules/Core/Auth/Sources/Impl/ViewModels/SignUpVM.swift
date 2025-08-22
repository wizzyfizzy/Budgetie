//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import Combine
import AppLogging
import AuthAPI
import UIComponents

final class SignUpVM: ObservableObject {
    // MARK: - Dependencies
    @Injected private var saveUserSessionUC: SaveUserSessionUC
    @Injected private var logger: BTLogger

    // MARK: - Inputs
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    // MARK: - State
    @Published var isSecure: Bool = true
    @Published var isSecureConfirm: Bool = true
    @Published var agreeTerms: Bool = false
    @Published var isLoading: Bool = false
    @Published var isSignUpButtonEnabled: Bool = false
    @Published private(set) var errorMessage: String?
        
    private var cancellables = Set<AnyCancellable>()
    private let fileName = "SignUpVM"

    // MARK: - Initialization
    init() {
        setupBindings()
    }
    // MARK: - Computed Properties
    var isFormValid: Bool {
        return errorMessage == nil
    }
    
    // MARK: - Public
    func trackView() {
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingView.authSignUpScreen)")
    }
    
    func signUp(onSuccess: @escaping (String) -> Void = { _ in }) {
        // TODO: implement sign up API call
        guard isFormValid, !isLoading else { return }
        trackAction(TrackingAction.tapSignUp, email: email)

        isLoading = true
        errorMessage = nil
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                // TODO: Api call
                try await Task.sleep(nanoseconds: 1_000_000_000) // mock delay
                let userID = "user_\(UUID().uuidString)"
                
                errorMessage = nil
                onSuccess(userID)
            } catch {
                errorMessage = "Sign up failed. Please try again."
            }
        }
    }
    
    // MARK: - Errors
    enum SignUpError: LocalizedError {
        case userAlreadyExists
        var errorDescription: String? {
            switch self {
            case .userAlreadyExists:
                return "Sorry, the user already exists"
            }
        }
    }
}

// MARK: - Private
private extension SignUpVM {
    private func setupBindings() {
        let nameVal = FormValidator.namePublisher($name)
        let emailVal = FormValidator.emailPublisher($email)
        let passwordVal = FormValidator.passwordPublisher($password, confirmPassword: $confirmPassword)
        let agreeTermsVal = FormValidator.agreeTermsPublisher($agreeTerms)

        Publishers.CombineLatest4(nameVal, emailVal, passwordVal,agreeTermsVal)
            .map { nameError, emailError, passwordError, agreeTermsError -> (String?) in
                [nameError, emailError, passwordError, agreeTermsError].compactMap { $0 }.isEmpty ? nil : [nameError, emailError, passwordError, agreeTermsError].compactMap { $0 }.joined(separator: "\n")
            }
            .sink {  [weak self] error in
                guard let self else { return }
                self.errorMessage = error
                self.isSignUpButtonEnabled = error == nil
            }
            .store(in: &cancellables)
    }
    
    // TODO: Replace with real API.
    
    private func signUpSuccess(userId: String, email: String, name: String) {
        let user = UserData(id: userId, email: email, name: name, token: "")
        do {
            try saveUserSessionUC.execute(user: user)
            trackAction(TrackingAction.completedSignUp, userId: user.id)
        } catch {
            errorMessage = "Failed to save session"
            logger.log(.error, fileName: fileName, "Failed to save session")
        }
    }
    
    // MARK: - Tracking
    private func trackAction(_ action: TrackingAction, email: String) {
        logger.log(.debug, fileName: fileName, "Tracking Action: \(action) for user with \(TrackingValue.email): \(email, keep: 4)")
    }
    
    private func trackAction(_ action: TrackingAction, userId: String = "Anonymous") {
        logger.log(.debug, fileName: fileName, "Tracking Action: \(action) for user with \(TrackingValue.userId): \(userId, keep: 4)")
    }
}
