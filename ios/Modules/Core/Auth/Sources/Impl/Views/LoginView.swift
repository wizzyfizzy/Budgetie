//
// Copyright © 2019 ___ORGANIZATIONNAME___
// All rights reserved.
//

import SwiftUI
import UIComponents
import AuthenticationServices

public struct LoginView: View {
    @StateObject private var loginVM: LoginVM
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState
    
    public init() {
        _loginVM = StateObject(wrappedValue: LoginVM())
    }
    
    private let background = LinearGradient(colors: [Color.btLightGreen, Color.btLightYellow],
                                            startPoint: .top, endPoint: .bottom)
    private let imageHeight: CGFloat = 140
    private let borderWidth: CGFloat = 4
    
    public var body: some View {
        ZStack {
            background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    
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
        VStack(spacing: Spacing.spaceL) {
            // Email
            emailTextField
            // Password
            passwordField
            // Remember Me
            rememberMeToggle
            // Forgot Password
            forgotPassword
            // Error message
            errorView
            
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
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.spaceXL, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(.medium)
        )
        .padding(.horizontal)
        .accessibilityElement(children: .contain)
        
        Spacer(minLength: Spacing.spaceL)
    }
    
    @ViewBuilder
    var emailTextField: some View {
        LabeledContent {
            TextField("you@example", text: $loginVM.email)
                .font(.appBody)
                .foregroundColor(.btBlack)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.next)
                .accessibilityIdentifier("login_email")
            
        } label: {
            Label("Email", systemImage: "envelope.fill")
                .font(.appBody)
                .foregroundColor(.btBlack)
        }
    }
    
    @ViewBuilder
    var passwordField: some View {
        LabeledContent {
            HStack(spacing: Spacing.spaceS) {
                Group {
                    if loginVM.isSecure {
                        SecureField("••••••••", text: $loginVM.password)
                            .textContentType(.password)
                    } else {
                        TextField("Enter password", text: $loginVM.password)
                            .textContentType(.password)
                    }
                }
                .submitLabel(.go)
                .accessibilityIdentifier("login_password")
                
                Button {
                    loginVM.isSecure.toggle()
                    let announcement = loginVM.isSecure
                    ? "Password is now hidden."
                    : "Password is now visible."
                    UIAccessibility.post(notification: .announcement, argument: announcement)
                    
                } label: {
                    Image(systemName: loginVM.isSecure ? "eye.slash.fill" : "eye.fill")
                }
                .buttonStyle(.plain)
                .accessibilityLabel(loginVM.isSecure ? "Show password" : "Hide password")
                .accessibilityHint("Toggles password visibility")
                .accessibilityValue(loginVM.isSecure ? "Hidden" : "Visible")
            }
        } label: {
            Label("Password", systemImage: "lock.fill")
        }
    }
    
    @ViewBuilder
    var rememberMeToggle: some View {
        HStack {
            Toggle(isOn: $loginVM.rememberMe) {
                Text("Remember me")
            }
            .toggleStyle(.switch)
            .foregroundColor(.btBlack)
            .accessibilityIdentifier("login_remember")
            .accessibilityHint("If enabled, your login will be securely stored on this device.")
        }
    }
    
    @ViewBuilder
    var forgotPassword: some View {
        TextButton(text: "Forgot password?", color: .btBlue) {
            //TODO:
            // hook to navigation → e.g. navigateToUC.execute(data: ResetPasswordNavData(), type: .sheet)
        }
    }
    
    @ViewBuilder
    var errorView: some View {
        if let error = loginVM.errorMessage {
            Text(error)
                .font(.appBody)
                .foregroundStyle(Color.btRed)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityIdentifier("login_error")
        }
    }

    @ViewBuilder
    var loginButton: some View {
        BorderButton(isLoading: $loginVM.isLoading, text: "Sign In", color: .btBlue) {
            guard loginVM.isFormValid, !loginVM.isLoading else { return }
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
        HStack(spacing: Spacing.spaceXS) {
            Text("No account?")
                .font(.appBody)
                .foregroundColor(.btBlack)
            TextButton(text: "Create one", color: .btBlue) {
                // TODO: navigate to SignUp
            }
            .font(.appBody)
            .frame(maxWidth: .infinity)
        }
        .font(.callout)
        .padding(.top, Spacing.spaceXS)
    }

}

#Preview {
    LoginView()
}
