//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

struct HelpSectionView: View {
    @Binding var path: [ProfileRoute]

    var body: some View {
        SectionCard(title: TextKeys.textProfileHelpLegal) {
            SettingsRow(title: TextKeys.textProfileFAQ, systemImage: "questionmark.circle") {
                path.append(.faq)
            }
            
            Divider()
            
            SettingsRow(title: TextKeys.textProfilePrivacyPolicy, systemImage: "shield") {
                path.append(.privacy)
            }
            
            Divider()
            
            SettingsRow(title: TextKeys.textProfileTermsOfService, systemImage: "doc.text") {
                path.append(.terms)
            }
        }
    }
}
