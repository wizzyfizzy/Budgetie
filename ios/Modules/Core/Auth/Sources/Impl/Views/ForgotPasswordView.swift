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
    @StateObject private var forgotPasswordVM: ForgotPasswordVM = ForgotPasswordVM()

    init(path: Binding<[AuthRoute]>) {
        _path = path
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Reset Password")
                .font(.appTitle)
                .foregroundColor(.btBlack)
                .padding(.bottom, Spacing.spaceL)

            TextField("Enter your email", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)
                .font(.appBody)
                .foregroundColor(.btBlack)
                .padding(.bottom, Spacing.spaceL)

//            BorderButton(isEnabled: $forgotPasswordVM.buttonShouldBeEnabled, isLoading: $forgotPasswordVM.isLoading, text: "Send Reset Link", color: .btBlue) {
//                guard forgotPasswordVM.isFormValid, !forgotPasswordVM.isLoading else { return }
//                // TODO: trigger reset password logic
//                forgotPasswordVM.forgotPassword()
//            }
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView(path: .constant([]))
}
