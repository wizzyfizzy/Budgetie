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
import BTRestClientAPI

final class SignUpVM: ObservableObject {
    // MARK: - Dependencies
    @Injected private var saveUserSessionUC: SaveUserSessionUC
    @Injected private var signUpUserUC: SignUpUserUC
    @Injected private var logger: BTLogger

    // MARK: - Inputs
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var agreeTerms: Bool = false

    // MARK: - State
    @Published var isSecure: Bool = true
    @Published var isSecureConfirm: Bool = true
    @Published var isLoading: Bool = false
    @Published var isSignUpButtonEnabled: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var shouldDismissView: Bool = false
    @Published var alert: BTAlert?

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
    
    @MainActor
    func signUp() async {
        guard isFormValid, !isLoading else { return }
        trackAction(TrackingAction.tapSignUp, email: email)
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        do {
            let loggedUser = try await signUpUserUC.execute(name: name, email: email, password: password)
            signUpSuccess(userData: loggedUser)
            shouldDismissView = true
        } catch HTTPError.userExists {
            logger.log(.error, fileName: fileName, "This user already exists, in signUp")
            alert = .error("Sign Up failed", "This user already exists")
        } catch {
            logger.log(.error, fileName: fileName, "Something went wrong in signUp")
            alert = .error("Error", "Something went wrong. Please try again later")
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

        Publishers.CombineLatest4(nameVal, emailVal, passwordVal, agreeTermsVal)
            .map { nameError, emailError, passwordError, agreeTermsError -> (String?) in
                [nameError, emailError, passwordError, agreeTermsError].compactMap { $0 }.isEmpty ? nil : [nameError, emailError, passwordError, agreeTermsError].compactMap { $0 }.joined(separator: "\n")
            }
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] error in
                guard let self else { return }
                self.errorMessage = error
                self.isSignUpButtonEnabled = error == nil
            }
            .store(in: &cancellables)
    }
        
    private func signUpSuccess(userData: UserData) {
        do {
            try saveUserSessionUC.execute(user: userData)
            trackAction(TrackingAction.completedSignUp, userId: userData.id)
        } catch {
            logger.log(.error, fileName: fileName, "Failed to save session in signUpSuccess")
            alert = .error("Error", "Failed to signUp. Please try again later")
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
