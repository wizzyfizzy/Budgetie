//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents
import AuthenticationServices

struct LoginView: View {
    @Binding var path: [AuthRoute]
    @StateObject private var loginVM: LoginVM = LoginVM()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState

    init(path: Binding<[AuthRoute]>) {
        _path = path
    }
    
    private let background = LinearGradient(colors: [Color.btLightGreen, Color.btLightYellow],
                                            startPoint: .top, endPoint: .bottom)
    private let imageHeight: CGFloat = 140
    private let borderWidth: CGFloat = 4
    
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: Spacing.spaceXL) {
                    // MARK: Branding
                    introView
                        .padding(.top, Spacing.spaceXL)
                    // MARK: Card
                    card
                }
            }
        }
    }
    
    @ViewBuilder
    var introView: some View {
        VStack(spacing: Spacing.spaceS) {
            Image(ImageKeys.imageAppIconAndSlogan)
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
                .accessibilityHidden(true)
            
            Text(TextKeys.textAuthWelcomeBack.localized())
                .font(.appTitle.bold())
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
            
            Text(TextKeys.textAuthSignIn.localized())
                .font(.appBody)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    var card: some View {
        VStack(spacing: Spacing.spaceM) {
            // Email
            EmailTextField(email: $loginVM.email)
            // Password
            PasswordField(password: $loginVM.password, isSecure: $loginVM.isSecure)
            // Remember Me
            RememberMeToggle(rememberMe: $loginVM.rememberMe)
            // Forgot Password
            forgotPassword
            // Error message
            ErrorView(errorMessage: loginVM.errorMessage)
            // Login Button
           loginButton
            // Or divider
            dividerView
            // Sign in with Apple
            appleLoginButton
            // Create account
            createAccount
        }
        .onAppear {
            loginVM.onAppear()
        }
        .padding(Spacing.spaceXL)
        .modifier(CardModifier())
        .padding(Spacing.spaceXL)
        .accessibilityElement(children: .contain)
        Spacer(minLength: Spacing.spaceL)
    }
    
    @ViewBuilder
    var forgotPassword: some View {
        TextButton(text: "Forgot password?", color: .btBlue) {
            path.append(.forgotPassword)
        }
    }

    @ViewBuilder
    var loginButton: some View {
        BorderButton(isEnabled: $loginVM.isLoginButtonEnabled, isLoading: $loginVM.isLoading, text: "Sign In", color: .btBlue) {
            guard loginVM.isFormValid, !loginVM.isLoading else { return }
            // TODO: call signIn
            loginVM.signIn()
            //                    .sink { completion in
            //                        if case .failure(let err) = completion {
            //                            loginVM.errorMessage = err.localizedDescription
            //                            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            //                        }
            //                    } receiveValue: { userID in
            //                        // Persist token/ID if rememberMe
            //                    // TODO: later: Keychain)
            //                        appState.userID = userID
            //                        dismiss()
            //                    }
            //                    .store(in: &cancellableBag)
        }
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    var dividerView: some View {
        HStack {
            Rectangle().frame(height: 1).opacity(0.2)
            Text("or")
                .font(.caption)
                .foregroundStyle(.secondary)
            Rectangle().frame(height: 1).opacity(0.2)
        }
    }
    
    @ViewBuilder
    var appleLoginButton: some View {
        SignInWithAppleButton(.signIn, onRequest: { _ in
        }, onCompletion: { _ in
            // TODO:
            // Handle ASAuthorization; on success:
            // appState.userID = "apple_" + someHash
             dismiss()
        })
        .signInWithAppleButtonStyle(.black)
        .frame(height: ButtonSize.heightMd)
        .clipShape(RoundedRectangle(cornerRadius: Spacing.spaceM))
        .accessibilityIdentifier("login_apple")
    }
    
    @ViewBuilder
    var createAccount: some View {
        HStack(spacing: Spacing.spaceS) {
            Text("No account?")
                .font(.appBody)
                .foregroundColor(.btBlack)
            TextButton(text: "Create one", color: .btBlue) {
                path.append(.register)
            }
            Spacer()
        }
        .padding(.top, Spacing.spaceXS)
    }

}

#Preview {
    LoginView(path: .constant([]))
        .environmentObject(AppState())
}
