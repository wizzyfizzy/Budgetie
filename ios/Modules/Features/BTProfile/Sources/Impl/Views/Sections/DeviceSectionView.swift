//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct DeviceSectionView: View {
    var appVersion: String
    var deviceName: String

    var body: some View {
        SectionCard(title: TextKeys.textProfileDeviceApp) {
            HStack {
                Label(LocalizedStringKey(TextKeys.textProfileAppVersion), systemImage: "info.circle")
                    .font(.appBody)
                    .foregroundColor(.btBlack)
                Spacer()
                Text(appVersion)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, Spacing.spaceM)

            Divider()
            
            HStack {
                Label(LocalizedStringKey(TextKeys.textProfileDeviceName), systemImage: "iphone")
                    .font(.appBody)
                    .foregroundColor(.btBlack)
                Spacer()
                Text(deviceName)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, Spacing.spaceM)
        }
    }
}
