//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct PasswordField: View {
    @Binding var password: String
    @Binding var isSecure: Bool

    init(password: Binding<String>, isSecure: Binding<Bool>) {
        _password = password
        _isSecure = isSecure
    }
    
    var body: some View {
        LabeledContent {
            HStack(spacing: Spacing.spaceS) {
                Group {
                    if isSecure {
                        SecureField("••••••••", text: $password)
                            .textContentType(.password)
                    } else {
                        TextField("Enter password", text: $password)
                            .textContentType(.password)
                    }
                }
                .submitLabel(.go)
                .accessibilityIdentifier("login_password")
                
                Button {
                    isSecure.toggle()
                    let announcement = isSecure
                    ? "Password is now hidden."
                    : "Password is now visible."
                    UIAccessibility.post(notification: .announcement, argument: announcement)
                    
                } label: {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isSecure ? "Show password" : "Hide password")
                .accessibilityHint("Toggles password visibility")
                .accessibilityValue(isSecure ? "Hidden" : "Visible")
            }
        } label: {
            Label("Password", systemImage: "lock.fill")
        }
        .frame(minHeight: Spacing.spaceXL)
    }
}

struct PasswordField_Previews: PreviewProvider {
    @State static var password = ""
    @State static var isSecure = true

    static var previews: some View {
        PasswordField(password: $password, isSecure: $isSecure)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
