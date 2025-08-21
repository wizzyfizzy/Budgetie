//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

enum TextFieldType: Hashable {
    case email
    case simple
}
struct GenericTextField: View {
    @Binding var userInput: String
    var textLabel: String
    var type: TextFieldType

    init(userInput: Binding<String>, textLabel: String, type: TextFieldType = .email) {
        _userInput = userInput
        self.textLabel = textLabel
        self.type = type
    }
    
    var body: some View {
        LabeledContent {
            TextField("Type here...", text: $userInput)
                .font(.appBody)
                .foregroundColor(.btBlack)
                .textContentType(type == .email ? .emailAddress : .name)
                .keyboardType(type == .email ? .emailAddress : .default)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.next)
                .accessibilityIdentifier("login_\(textLabel)")
            
        } label: {
            Label(textLabel, systemImage: type == .email ? "envelope.fill" : "person.fill")
                .font(.appBody)
                .foregroundColor(.btBlack)
        }
        .frame(minHeight: Spacing.spaceXL)
    }
}

struct GenericTextField_Previews: PreviewProvider {
    @State static var userInput = ""
    var textLabel: String
    var type: TextFieldType
    
    static var previews: some View {
        GenericTextField(userInput: $userInput, textLabel: "Email")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
