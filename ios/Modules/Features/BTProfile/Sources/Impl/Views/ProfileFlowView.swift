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
    @StateObject private var viewModel = ProfileVM()

    var body: some View {
        NavigationStack(path: $path) {
            ProfileView(path: $path, viewModel: viewModel)
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .faq:
                        FAQView(viewModel: viewModel)
                    case .privacy:
                        PrivacyPolicyView(viewModel: viewModel)
                    case .terms:
                        TermsOfServiceView(viewModel: viewModel)
                    }
                }
        }
    }
}
