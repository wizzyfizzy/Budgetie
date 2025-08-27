//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import SwiftUI
import UIComponents

struct PrivacyPolicyView: View {
    private let privacyText = LocalizedStringKey(TextKeys.textProfilePrivacyPolicyContent)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.spaceL) {
                Text(LocalizedStringKey(TextKeys.textProfilePrivacyPolicy))
                    .font(.appTitle)
                    .foregroundColor(.btBlack)
                    .bold()
                    .padding(.bottom, Spacing.spaceS)

                Text(privacyText)
                    .font(.appBody)
                    .foregroundColor(.btBlack)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel(LocalizedStringKey(TextKeys.textProfilePrivacyPolicyAccessibility))
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey(TextKeys.textProfilePrivacyPolicy))
    }
}
