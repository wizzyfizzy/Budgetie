//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct SettingsSectionView: View {
    @Binding var darkMode: Bool
    @Binding var language: String
    
    private let pickerWidth: CGFloat = 140.0
    var body: some View {
        SectionCard(title: TextKeys.textProfileSettings) {
            Toggle(isOn: $darkMode) {
                Label(LocalizedStringKey(TextKeys.textProfileDarkMode), systemImage: darkMode ? "moon.fill" : "sun.max.fill")
                    .font(.appBody)
                    .foregroundColor(.btBlack)
            }
            .padding(.vertical, Spacing.spaceM)
            
            Divider()
            
            HStack {
                Label(LocalizedStringKey(TextKeys.textProfileLanguage), systemImage: "globe")
                    .font(.appBody)
                    .foregroundColor(.btBlack)
                Spacer()
                Picker("", selection: $language) {
                    Text(LocalizedStringKey(TextKeys.textProfileLanguageEnglish))
                        .tag("en")
                    Text(LocalizedStringKey(TextKeys.textProfileLanguageGreek))
                        .tag("el")
                }
                .pickerStyle(.segmented)
                .frame(width: pickerWidth)
            }
            .padding(.vertical, Spacing.spaceM)
        }
    }
}
