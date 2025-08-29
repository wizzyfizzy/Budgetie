//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct LoggedOutProfileView: View {
    @Binding var path: [ProfileRoute]
    @ObservedObject private var viewModel: ProfileVM

    init(path: Binding<[ProfileRoute]>,
         viewModel: ProfileVM) {
        _path = path
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: Spacing.spaceXL) {
                
                // MARK: User Card
                LoggedOutCardView(viewModel: viewModel)
                
                // MARK: Section - Settings
                SettingsSectionView(darkMode: $viewModel.isDarkMode,
                                    language: $viewModel.language)
                
                // MARK: Section - Notifications
                NotificationSectionView(path: $path,
                                        notificationsEnabled: $viewModel.notificationsEnabled,
                                        reminderTime: $viewModel.notificationsReminderTime)
                
                // MARK: Section - Help & Legal
                HelpSectionView(path: $path)

                // MARK: Section - Device
                DeviceSectionView(appVersion: viewModel.appVersion, deviceName: viewModel.deviceName)
                    .padding(.bottom, Spacing.spaceM)
            
                Spacer()
            }
            .padding(Spacing.spaceXL)
        }
        .navigationTitle("Profile")
        .onAppear {
            viewModel.trackView(TrackingView.profileLoggedOutScreen)
        }
    }
}

struct LoggedOutCardView: View {
    private let imageSize: CGFloat = 80.0
    @ObservedObject private var viewModel: ProfileVM
    
    init(viewModel: ProfileVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: Spacing.spaceM) {
            Image(systemName: "lock.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.btGray)
                .frame(width: 120, height: 120)
                .accessibilityHidden(true)
            
            Text(LocalizedStringKey(TextKeys.textProfileLoginMessage))
                .font(.appBody)
                .foregroundColor(.btBlack)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .accessibilityLabel(LocalizedStringKey(TextKeys.textProfileLoginAccessibility))
            
            GradientButton(text: TextKeys.textButtonLogin) {
                viewModel.onTapLogin()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .accessibilityLabel(LocalizedStringKey(TextKeys.textButtonLogin))
            .accessibilityHint(LocalizedStringKey(TextKeys.textButtonLoginAccessibility))
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.btCardBg)
        .cornerRadius(CornerRadius.spaceL)
        .shadow(.large)
    }
}
