//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct SettingsRow: View {
    let title: String
    let systemImage: String
    let action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
        }, label: {
            HStack {
                Image(systemName: systemImage)
                    .frame(width: IconSize.spaceL)
                    .foregroundColor(.btBlack)
                Text(LocalizedStringKey(title))
                    .font(.appBody)
                    .foregroundColor(.btBlack)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.btBlue)
            }
            .padding(.vertical, Spacing.spaceM)
            .background(Color.clear)
        })
    }
}
