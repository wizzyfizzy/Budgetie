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
    @Injected private var loginUserUC: LoginUserUC
    @Injected private var logger: BTLogger

    // MARK: - Inputs
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - State
    @Published var isSecure: Bool = true
    @Published var isLoading: Bool = false
    @Published var isLoginButtonEnabled: Bool = true
    @Published private(set) var errorMessage: String?
    @Published var shouldDismissView: Bool = false
    @Published var alert: BTAlert?

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
    
    @MainActor
    func loginWithApple() async -> Bool {
        trackAction(TrackingAction.tapSignInWithApple)
        isLoading = true
        defer { isLoading = false }
        do {
            let cred = try await appleSignInManager.requestAuthorization()
            guard let credEmail = cred.email else { return false }
            return await performLogin(email: credEmail, password: "AppleLogin")
        } catch {
            logger.log(.error, fileName: fileName, "\(error.localizedDescription)")
            alert = .error("Login Error", "Something went wrong with Apple Login. Please try again later")

            return false
        }
    }
    
    @MainActor
    func login() async {
        guard isFormValid, !isLoading else { return }
        trackAction(TrackingAction.tapSignIn, email: email)
        _ = await performLogin(email: email, password: password)
    }
}

// MARK: - Private
private extension LoginVM {
    private func setupBindings() {
        Publishers.CombineLatest(
            FormValidator.emailPublisher($email),
            FormValidator.passwordPublisher($password, confirmPassword: $password)
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] emailError, passwordError in
            guard let self else { return }
            let errors = [emailError, passwordError].compactMap { $0 }
            self.errorMessage = errors.isEmpty ? nil : errors.joined(separator: "\n")
            self.isLoginButtonEnabled = errors.isEmpty
        }
        .store(in: &cancellables)
    }
    private func loginSuccess(userData: UserData) {
        do {
            try saveUserSessionUC.execute(user: userData)
            trackAction(TrackingAction.completedSignIn, userId: userData.id)
            shouldDismissView = true
        } catch {
            alert = .error("Login Error", "Failed to login. Please try again later")
            logger.log(.error, fileName: fileName, "Failed to save session in loginSuccess")
        }
    }
    
    // MARK: - Tracking
    private func trackAction(_ action: TrackingAction, email: String) {
        logger.log(.debug, fileName: fileName, "Tracking Action: \(action) for user with \(TrackingValue.email): \(email, keep: 4)")
    }
    
    private func trackAction(_ action: TrackingAction, userId: String = "Anonymous") {
        logger.log(.debug, fileName: fileName, "Tracking Action: \(action) for user with \(TrackingValue.userId): \(userId, keep: 4)")
    }
    
    @MainActor
    private func performLogin(email: String, password: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        do {
            let loggedUser = try await loginUserUC.execute(email: email, password: password)
            loginSuccess(userData: loggedUser)
            return true
        } catch AuthAPIError.invalidCredentials {
            alert = .error("Login Error", "Invalid email or password")
            logger.log(.error, fileName: fileName, "Invalid email or password")
            return false
        } catch {
            alert = .error("Login Error", "Something went wrong. Please try again later")
            logger.log(.error, fileName: fileName, "Failed to login in performLogin")
            return false
        }
    }
}
