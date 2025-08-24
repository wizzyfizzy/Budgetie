//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents
import AuthenticationServices

struct SignUpView: View {
    @Binding var path: [AuthRoute]
    @Binding var shouldDismiss: Bool
    @StateObject private var signUpVM: SignUpVM = SignUpVM()
//    @EnvironmentObject private var appState: AppState
    
    private let imageHeight: CGFloat = 140

    init(path: Binding<[AuthRoute]>, shouldDismiss: Binding<Bool>) {
        _path = path
        _shouldDismiss = shouldDismiss
    }

    var body: some View {
        ZStack {
            LinearGradient.appBackground
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: Spacing.spaceXL) {
                    // MARK: Branding
                    brandingView
                    // MARK: Card
                    formCard
                }
            }
        }
        .onAppear {
            signUpVM.trackView()
        }
        .alert(item: $signUpVM.alert) { alert in
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
              
              Text("Welcome!")
                  .font(.appTitle.bold())
                  .multilineTextAlignment(.center)
                  .accessibilityAddTraits(.isHeader)
              
              Text("Create your account to get started")
                  .font(.appBody)
                  .foregroundStyle(.secondary)
                  .multilineTextAlignment(.center)
          }
      }
      
    @ViewBuilder
    var formCard: some View {
        VStack(spacing: Spacing.spaceL) {
            // Name
            GenericTextField(userInput: $signUpVM.name, textLabel: "Name", type: .simple)
            // Email
            GenericTextField(userInput: $signUpVM.email, textLabel: "Email")
            // Password
            SecureTextField(password: $signUpVM.password, isSecure: $signUpVM.isSecure, textLabel: "Password")
            // Confirm Password
            SecureTextField(password: $signUpVM.confirmPassword, isSecure: $signUpVM.isSecureConfirm, textLabel: "Confirm Password")
            
            // Terms and conditions
            Toggle(isOn: $signUpVM.agreeTerms) {
                Text("I agree to the Terms & Conditions")
                    .font(.appBody)
            }
            .toggleStyle(.switch)
            // Error message
            ErrorView(errorMessage: signUpVM.errorMessage)
            // Sign Up Button
            signUpButton
            // Divider
            Rectangle().frame(height: 1).opacity(0.2)
            // Login to account section
            loginToAccount
        }
        .padding(Spacing.spaceXL)
        .modifier(CardModifier())
        .accessibilityElement(children: .contain)
    }
    
    @ViewBuilder
    var signUpButton: some View {
        BorderButton(isEnabled: $signUpVM.isSignUpButtonEnabled, isLoading: $signUpVM.isLoading, text: "Sign Up", color: .btBlue) {
            KeyboardHelper.dismiss()
            Task {
                await signUpVM.signUp()
                if signUpVM.shouldDismissView {
                    path.removeAll()
                    shouldDismiss = true
                }
            }
        }
            .frame(maxWidth: .infinity)
            .accessibilityIdentifier("signup_button")
    }

    @ViewBuilder
    var loginToAccount: some View {
        HStack(spacing: Spacing.spaceXS) {
            Text("Already have an account?")
                .font(.appBody)
                .foregroundColor(.btBlack)
            TextButton(text: "Sign In", color: .btBlue) {
                if !path.isEmpty { path.removeLast() }
            }
            Spacer()
        }
    }
}

#Preview {
    SignUpView(path: .constant([]), shouldDismiss: .constant(false))
}
