//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct SectionCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.spaceM) {
            Text(LocalizedStringKey(title))
                .font(.appTitle2)
                .foregroundColor(.btBlack)
                .padding(.horizontal, Spacing.spaceM)
            
            VStack(spacing: .zero) {
                content
            }
            .padding(.horizontal, Spacing.spaceM)
            .frame(maxWidth: .infinity)
            .background(Color.btCardBg)
            .cornerRadius(CornerRadius.spaceM)
            .shadow(.large)
        }
    }
}
