//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct ForgotPasswordView: View {
    @Binding var path: [AuthRoute]
    @StateObject private var forgotPasswordVM = ForgotPasswordVM()
    
    private let imageHeight: CGFloat = 140
    
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
            forgotPasswordVM.trackView()
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
            
            Text("Forgot Password?")
                .font(.appTitle.bold())
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
            
            Text("Enter your email and we’ll send you a reset link")
                .font(.appBody)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    var formCard: some View {
        VStack(spacing: Spacing.spaceL) {
            // Email
            GenericTextField(userInput: $forgotPasswordVM.email,
                             textLabel: "Email")
            
            // Error message
            ErrorView(errorMessage: forgotPasswordVM.errorMessage)
            // Reset Button
            resetPasswordButton
        }
        .padding(Spacing.spaceXL)
        .modifier(CardModifier())
        .accessibilityElement(children: .contain)
    }
    
    @ViewBuilder
    var resetPasswordButton: some View {
        BorderButton(isEnabled: $forgotPasswordVM.isResetButtonEnabled,
                     isLoading: $forgotPasswordVM.isLoading,
                     text: "Send Reset Link",
                     color: .btBlue) {
            forgotPasswordVM.resetPassword { success in
                if success {
                    if !path.isEmpty { path.removeLast() }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ForgotPasswordView(path: .constant([.forgotPassword]))
}
