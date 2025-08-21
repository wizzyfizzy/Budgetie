//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct SecureTextField: View {
    @Binding var password: String
    @Binding var isSecure: Bool
    var textLabel: String

    init(password: Binding<String>, isSecure: Binding<Bool>, textLabel: String) {
        _password = password
        _isSecure = isSecure
        self.textLabel = textLabel
    }
    
    var body: some View {
        LabeledContent {
            HStack(spacing: Spacing.spaceS) {
                Group {
                    if isSecure {
                        SecureField("••••••••", text: $password)
                            .textContentType(.password)
                    } else {
                        TextField("Enter \(textLabel)", text: $password)
                            .textContentType(.password)
                    }
                }
                .submitLabel(.go)
                .accessibilityIdentifier("login_\(textLabel)")
                
                Button {
                    isSecure.toggle()
                    let announcement = isSecure
                    ? "\(textLabel) is now hidden."
                    : "\(textLabel) is now visible."
                    UIAccessibility.post(notification: .announcement, argument: announcement)
                    
                } label: {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isSecure ? "Show password" : "Hide \(textLabel)")
                .accessibilityHint("Toggles \(textLabel) visibility")
                .accessibilityValue(isSecure ? "Hidden" : "Visible")
            }
        } label: {
            Label(textLabel, systemImage: "lock.fill")
        }
        .frame(minHeight: Spacing.spaceXL)
    }
}

struct SecureTextField_Previews: PreviewProvider {
    @State static var password = ""
    @State static var isSecure = true

    static var previews: some View {
        SecureTextField(password: $password, isSecure: $isSecure, textLabel: "Password")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
