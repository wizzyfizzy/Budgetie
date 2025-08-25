//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import Foundation
import Combine
import AppLogging
import UIComponents
import BTRestClientAPI

final class ForgotPasswordVM: ObservableObject {
    // MARK: - Dependencies
    @Injected private var forgotPasswordUC: ForgotPasswordUC
    @Injected private var logger: BTLogger

    // MARK: - Inputs
    @Published var email: String = ""
    
    // MARK: - State
    @Published var isLoading: Bool = false
    @Published var isResetButtonEnabled: Bool = true
    @Published private(set) var errorMessage: String?
    @Published var alert: BTAlert?

    private var cancellables = Set<AnyCancellable>()
    private let fileName = "ForgotPasswordVM"

    // MARK: - Initialization
    init() {
        setupBindings()
    }
    
    // MARK: - Public
    func trackView() {
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingView.authForgotPasswordScreen)")
    }
    
    @MainActor
    func forgotPassword() async {
        guard isResetButtonEnabled, !isLoading else { return }
        trackAction(TrackingAction.tapForgotPassword, email: email)
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil
        
        do {
            let message = try await forgotPasswordUC.execute(email: email)
            alert = .success("Success", message)
        } catch HTTPError.missingFields {
            alert = .error("Error", "Invalid email")
            logger.log(.error, fileName: fileName, "Invalid email in forgotPassword")
        } catch {
            alert = .error("Error", "Something went wrong. Please try again later")
            logger.log(.error, fileName: fileName, "\(error.localizedDescription)")
        }
    }
}

// MARK: - Private
private extension ForgotPasswordVM {
    
    private func setupBindings() {
        FormValidator.emailPublisher($email)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else { return }
                    self.errorMessage = error
                    self.isResetButtonEnabled = error == nil
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Tracking
    private func trackAction(_ action: TrackingAction, email: String = "Anonymous") {
        logger.log(.debug, fileName: fileName, "Tracking Action: \(action) for user with \(TrackingValue.email): \(email)")
    }
}
