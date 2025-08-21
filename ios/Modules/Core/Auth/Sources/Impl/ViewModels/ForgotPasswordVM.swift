//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import Foundation
import Combine
import AppLogging

@MainActor
final class ForgotPasswordVM: ObservableObject {
    // MARK: - Dependencies
    @Injected private var logger: BTLogger

    // MARK: - Inputs
    @Published var email: String = ""
    
    // MARK: - State
    @Published var isLoading: Bool = false
    @Published var isResetButtonEnabled: Bool = true
    @Published private(set) var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let fileName = "ForgotPasswordVM"

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
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingView.authForgotPasswordScreen)")
    }
    
    func resetPassword(completion: @escaping (Bool) -> Void) {
        guard isFormValid, !isLoading else { return }
        trackAction(TrackingAction.tapForgotPassword, email: email)
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                // 🔹 Mock delay / replace with real API
                try await Task.sleep(nanoseconds: 1_000_000_000)
                errorMessage = nil
                completion(true)
            } catch {
                errorMessage = "Something went wrong. Try again."
                completion(false)
            }
        }
    }
}

// MARK: - Private
private extension ForgotPasswordVM {
    
    private func setupBindings() {
        $email
            .removeDuplicates()
            .map { email -> (String?, Bool) in
                var errors: [String] = []
                if  email.isEmpty {
                    errors.append("Please fill in your email.")
                } else if !email.isValidEmail {
                    errors.append("Invalid email format.")
                }
                let combinedError = errors.isEmpty ? nil : errors.joined(separator: "\n")
                return (combinedError, combinedError == nil)
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] error, isEnabled in
                self?.errorMessage = error
                self?.isResetButtonEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Tracking
    private func trackAction(_ action: TrackingAction, email: String = "Anonymous") {
        logger.log(.debug, fileName: fileName, "Tracking Action: \(action) for user with \(TrackingValue.email): \(email)")
    }
}
