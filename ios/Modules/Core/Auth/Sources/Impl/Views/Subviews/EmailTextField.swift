//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct EmailTextField: View {
    @Binding var email: String
    
    init(email: Binding<String>) {
        _email = email
    }
    
    var body: some View {
        LabeledContent {
            TextField("you@example", text: $email)
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
        .frame(minHeight: Spacing.spaceXL)
    }
}

struct EmailTextField_Previews: PreviewProvider {
    @State static var email = ""

    static var previews: some View {
        EmailTextField(email: $email)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
