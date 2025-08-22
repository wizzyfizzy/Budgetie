//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import Combine
import AuthAPI
import AppLogging
import UIComponents

final class LoginVM: ObservableObject {
    // MARK: - Dependencies
    @Injected private var saveUserSessionUC: SaveUserSessionUC
    @Injected private var logger: BTLogger

    // MARK: - Inputs
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - State
    @Published var isSecure: Bool = true
    @Published var isLoading: Bool = false
    @Published var isLoginButtonEnabled: Bool = true
    @Published private(set) var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    var userID: String?
    var appleSignInManager = AppleSignInManager()
    private let fileName = "LoginVM"

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
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingView.authSignInScreen)")
    }
    func onTapCreateAccount() {
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingAction.tapCreateAccount)")
    }
    
    func onTapForgotPass() {
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingAction.tapForgotPassword)")
    }
    
    func loginWithApple() async -> Bool {
        trackAction(TrackingAction.tapSignInWithApple)
        isLoading = true
        defer { isLoading = false }
        do {
            let cred = try await appleSignInManager.requestAuthorization()
            // First-time sign-up: credential.email / credential.fullName available
            // Subsequent login: they may be nil
            // Handle register vs login flow accordingly
            // TODO: send them to backend
            // TODO: save them to saveUC
            return true
        } catch {
            logger.log(.error, fileName: fileName, "\(error.localizedDescription)")
            return false
        }
    }
    
    // TODO: Replace with real API.
    func login(onSuccess: @escaping (String) -> Void = { _ in }) {
        guard isFormValid, !isLoading else { return }
        trackAction(TrackingAction.tapSignIn, email: email)

        isLoading = true
        defer { isLoading = false }

        errorMessage = nil
        // TODO: call saveUC
//        loginSuccess
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
        let emailVal = FormValidator.emailPublisher($email)
        let passwordVal = FormValidator.passwordPublisher($password, confirmPassword: $password)

        // Combine email + password errors
        Publishers.CombineLatest(emailVal, passwordVal)
            .map { emailError, passwordError -> (String?) in
                [emailError, passwordError].compactMap { $0 }.isEmpty ? nil : [emailError, passwordError].compactMap { $0 }.joined(separator: "\n")
            }
            .sink { [weak self] error in
                guard let self else { return }
                self.errorMessage = error
                self.isLoginButtonEnabled = error == nil
            }
            .store(in: &cancellables)
    }
    
    private func loginSuccess(userId: String, email: String, name: String) {
        let user = UserData(id: userId, email: email, fullName: name)
        do {
            try saveUserSessionUC.execute(user: user)
            trackAction(TrackingAction.completedSignIn, userId: user.id)
        } catch {
            errorMessage = "Failed to login"
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
