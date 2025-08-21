//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import AuthenticationServices
import SwiftUI

@MainActor
final class AppleSignInManager: NSObject {
    private var continuation: CheckedContinuation<ASAuthorizationAppleIDCredential, Error>?
    
    func requestAuthorization() async throws -> ASAuthorizationAppleIDCredential {
        try await withCheckedThrowingContinuation { cont in
            self.continuation = cont
            
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.presentationContextProvider = self
            controller.performRequests()
        }
    }
}

extension AppleSignInManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization auth: ASAuthorization) {
        guard let cred = auth.credential as? ASAuthorizationAppleIDCredential else {
            continuation?.resume(throwing: NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        continuation?.resume(returning: cred)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation?.resume(throwing: error)
    }
}

extension AppleSignInManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.windows.first(where: \.isKeyWindow) }
            .first ?? UIWindow()
    }
}
