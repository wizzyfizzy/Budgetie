//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

enum ProfileRoute: Hashable {
    case faq
    case privacy
    case terms
}

struct ProfileFlowView: View {
    @State private var path: [ProfileRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ProfileView(path: $path)
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .faq:
                        FAQView()
                    case .privacy:
                        PrivacyPolicyView()
                    case .terms:
                        TermsOfServiceView()
                    }
                }
        }
    }
}
