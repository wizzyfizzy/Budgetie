//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import SwiftUI
import UIComponents

struct TermsOfServiceView: View {
    private let termsText = LocalizedStringKey(TextKeys.textProfileTermsOfServiceContent)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.spaceL) {
                Text(LocalizedStringKey(TextKeys.textProfileTermsOfService))
                    .font(.appTitle)
                    .foregroundColor(.btBlack)
                    .bold()
                    .padding(.bottom, Spacing.spaceS)

                Text(termsText)
                    .font(.appBody)
                    .foregroundColor(.btBlack)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel(LocalizedStringKey(TextKeys.textProfileTermsOfServiceAccessibility))
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey(TextKeys.textProfileTermsOfService))
    }
}
