//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents
import AuthAPI

struct LoggedInProfileView: View {
    @Binding var path: [ProfileRoute]
    @ObservedObject private var viewModel: ProfileVM
    let user: UserData
    
    init(path: Binding<[ProfileRoute]>,
         viewModel: ProfileVM,
         user: UserData) {
        _path = path
        self.viewModel = viewModel
        self.user = user
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.spaceXL) {
                
                // MARK: User Card
                UserCardView(user: user)
                
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
                // MARK: Logout Button
                logoutButton
                
                Spacer()
            }
            .padding(Spacing.spaceXL)
        }
        .navigationTitle("Profile")
        .onAppear {
            viewModel.trackView(TrackingView.profileLoggedInScreen)
        }
    }
    
    @ViewBuilder
    var logoutButton: some View {
        BorderButton(
            text: TextKeys.textProfileLogout,
            color: .btBlue) {
                viewModel.onTapLogout()
        }
        .frame(maxWidth: .infinity)
        .accessibilityLabel(LocalizedStringKey(TextKeys.textProfileLogout))
        .accessibilityHint(LocalizedStringKey(TextKeys.textProfileLogoutAccessibility))
        .alert(item: $viewModel.alert) { alert in
            alert.toAlert(
                primaryButtonAction: {
                    viewModel.onActionLogout()
                },
                secondaryButtonAction: {
                    viewModel.onCancelLogout()
                }
            )
        }
    }
}

struct UserCardView: View {
    let user: UserData
    private let imageSize: CGFloat = 80.0
    
    var body: some View {
        VStack(spacing: Spacing.spaceM) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(.btBlue)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.spaceXL))
                .shadow(.large)
                .accessibilityHidden(true)
            
            Text(user.name)
                .font(.appTitle)
                .bold()
                .foregroundColor(.btBlack)
                .accessibilityLabel("User name: \(user.name)")
            
            Text(user.email)
                .font(.appBody)
                .foregroundStyle(.secondary)
                .foregroundColor(.btBlack)
                .accessibilityLabel("Email: \(user.email)")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.btCardBg)
        .cornerRadius(CornerRadius.spaceL)
        .shadow(.large)
    }
}
