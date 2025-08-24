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
//    @EnvironmentObject private var appState: AppState

    init(path: Binding<[AuthRoute]>) {
        _path = path
    }
    
    private let imageHeight: CGFloat = 140
    private let borderWidth: CGFloat = 4
    
    var body: some View {
        ZStack {
            LinearGradient.appBackground
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: Spacing.spaceXL) {
                    // MARK: Branding
                    brandingView
                        .padding(.top, Spacing.spaceXL)
                    // MARK: Card
                    formCard
                }
            }
        }
        .onAppear {
            loginVM.trackView()
        }
        .alert(item: $loginVM.alert) { alert in
            alert.toAlert { }
        }
    }
    
    @ViewBuilder
    var brandingView: some View {
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
    var formCard: some View {
        VStack(spacing: Spacing.spaceM) {
            // Email
            GenericTextField(userInput: $loginVM.email, textLabel: "Email")
            // Password
            SecureTextField(password: $loginVM.password, isSecure: $loginVM.isSecure, textLabel: "Password")
            // Forgot Password
            forgotPassword
            // Error message
            ErrorView(errorMessage: loginVM.errorMessage)
            // Login Button
           loginButton
            // Or divider
            DividerView()
            // Sign in with Apple
            appleLoginButton
            // Create account section
            createAccount
        }
        .padding(Spacing.spaceXL)
        .modifier(CardModifier())
        .accessibilityElement(children: .contain)
        Spacer(minLength: Spacing.spaceL)
    }
    
    @ViewBuilder
    var forgotPassword: some View {
        TextButton(text: "Forgot password?", color: .btBlue) {
            loginVM.onTapForgotPass()
            path.append(.forgotPassword)
        }
    }

    @ViewBuilder
    var loginButton: some View {
        BorderButton(isEnabled: $loginVM.isLoginButtonEnabled, isLoading: $loginVM.isLoading, text: "Sign In", color: .btBlue) {
            KeyboardHelper.dismiss()
            Task {
                await loginVM.login()
                if loginVM.shouldDismissView {
                    path.removeAll()
                    dismiss()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .accessibilityIdentifier("login_button")
    }
    
    @ViewBuilder
    var appleLoginButton: some View {
        SignInWithAppleButton(.signUp) { _ in
        } onCompletion: { _ in
            Task {
                if await loginVM.loginWithApple() {
                    dismiss()
                }
            }
        }
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
                loginVM.onTapCreateAccount()
                path.append(.signUp)
            }
            Spacer()
        }
        .padding(.top, Spacing.spaceXS)
    }

}

#Preview {
    LoginView(path: .constant([]))
//        .environmentObject(AppState())
}
