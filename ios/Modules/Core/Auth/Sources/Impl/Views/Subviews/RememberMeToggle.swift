//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

struct RememberMeToggle: View {
    @Binding var rememberMe: Bool
    
    init(rememberMe: Binding<Bool>) {
        _rememberMe = rememberMe
    }
    
    var body: some View {
        HStack {
            Toggle(isOn: $rememberMe) {
                Text("Remember me")
            }
            .toggleStyle(.switch)
            .foregroundColor(.btBlack)
            .accessibilityIdentifier("login_remember")
            .accessibilityHint("If enabled, your login will be securely stored on this device.")
        }
    }
}

struct RememberMeToggle_Previews: PreviewProvider {
    @State static var rememberMe = false
    
    static var previews: some View {
        RememberMeToggle(rememberMe: $rememberMe)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
