//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct NotificationSectionView: View {
    
    @Binding var path: [ProfileRoute]
    @Binding var notificationsEnabled: Bool
    @Binding var reminderTime: Date

    private let pickerWidth: CGFloat = 140.0

    var body: some View {
        SectionCard(title: TextKeys.textProfileNotifications) {
            Toggle(isOn: $notificationsEnabled) {
                Label(LocalizedStringKey(TextKeys.textProfileEnableNotifications), systemImage: "bell.fill")
                    .font(.appBody)
                    .foregroundColor(.btBlack)
            }
            .padding(.vertical, Spacing.spaceM)
            
            if notificationsEnabled {
                Divider()
                HStack {
                    Label(LocalizedStringKey(TextKeys.textProfileReminderTime), systemImage: "clock.fill")
                        .font(.appBody)
                        .foregroundColor(.btBlack)
                    Spacer()
                    DatePicker("", selection: $reminderTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(width: pickerWidth, alignment: .trailing)
                }
                .padding(.vertical, Spacing.spaceM)
            }
        }
    }
}
