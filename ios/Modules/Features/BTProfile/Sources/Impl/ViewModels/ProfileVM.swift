//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Combine
import AuthAPI
import AppLogging
import UIComponents
import SwiftUI
import AppNavigationAPI

public final class ProfileVM: ObservableObject {
    // MARK: - Dependencies
    @Injected private var isLoggedInUC: IsLoggedInUC
    @Injected private var getUserSessionUC: GetUserSessionUC
    @Injected private var logoutUserUC: LogoutUserUC
    @Injected private var getProfileSettingsUC: GetProfileSettingsUC
    @Injected private var updateDarkModeUC: UpdateDarkModeUC
    @Injected private var updateLanguageUC: UpdateLanguageUC
    @Injected private var updateNotificationsUC: UpdateNotificationsUC
    @Injected private var updateReminderTimeUC: UpdateReminderTimeUC
    @Injected private var trackEventUC: TrackEventUC
    @Injected private var trackViewUC: TrackViewUC
    @Injected private var navigateToUC: AppNavigateToUC
    
    // MARK: - State
    @Published public private(set) var isLoggedIn: Bool = false
    @Published public private(set) var userData: UserData?
    
    @Published var isDarkMode: Bool {
        didSet {
            updateDarkModeUC.execute(enabled: isDarkMode)
            trackTap("\(TrackingAction.tapDarkMode.rawValue). \(TrackingValue.darkModeIs.rawValue) \(isDarkMode ? "On" : "Off")")
        }
    }
    
    @Published var language: String {
        didSet {
            updateLanguageUC.execute(language: language)
            trackTap("\(TrackingAction.tapLanguage.rawValue). \( TrackingValue.languageIs.rawValue) \(language)")
        }
    }
    
    @Published public var notificationsEnabled: Bool {
        didSet {
            updateNotificationsUC.execute(enabled: notificationsEnabled)
            trackTap("\(TrackingAction.tapEnableNotifications.rawValue). \( TrackingValue.enableNotificationsAre.rawValue) \(notificationsEnabled ? "Enabled" : "Disabled")")
        }
    }
    
    @Published public var notificationsReminderTime: Date {
        didSet {
            updateReminderTimeUC.execute(date: notificationsReminderTime)
            trackTap("\(TrackingAction.tapReminderTimer.rawValue). \( TrackingValue.reminderTimer.rawValue) \(notificationsReminderTime)")
        }
    }
    
    @Published var alert: BTAlert?
    
    private var cancellables = Set<AnyCancellable>()
    private let fileName = "ProfileVM"
    
    var appVersion: String = "1.0"
    var deviceName: String = "iphone"
    
    // MARK: - Initialization
    public init() {
        // Initialize simple stored properties first
        self.isDarkMode = false
        self.language = "en"
        self.notificationsEnabled = false
        self.notificationsReminderTime = Date()
        self.isLoggedIn = false
        self.userData = nil
        
        setup()
        setupAuthBindings()
    }
    
    // MARK: - Public
    func trackView(_ item: TrackingView) {
        trackViewUC.execute(fileName: fileName, event: item)
    }
    
    public func trackTap(_ item: LoggingMessage) {
        trackEventUC.execute(fileName: fileName, event: item)
    }
    
    public func onTapLogin() {
        trackTap("\(TrackingAction.tapLogin.rawValue)")
        navigateToUC.execute(data: AuthAPI.AuthFlowNavData(), type: .sheet)
    }
    
    public func onTapLogout() {
        trackTap("\(TrackingAction.tapLogout.rawValue) for user with email \(userData?.email ?? "", keep: 4) and id \(userData?.id ?? "")")
        alert = .info(TextKeys.textProfileLogout, TextKeys.textProfileLogoutAlert)
    }
    
    public func onActionLogout() {
        logoutUserUC.execute()
        trackTap("\(TrackingAction.tapLogoutCompleted.rawValue)")
    }
    
    public func onCancelLogout() {
        trackTap("\(TrackingAction.tapLogoutCancelled.rawValue)")
    }
}

// MARK: - Private
private extension ProfileVM {
    private func setupAuthBindings() {
        isLoggedInUC.executePublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoggedIn, on: self)
            .store(in: &cancellables)
        
        getUserSessionUC.executePublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.userData, on: self)
            .store(in: &cancellables)
    }
    
    private func setup() {
        let settings = getProfileSettingsUC.execute()
        self.isDarkMode = settings.isDarkMode
        self.language = settings.language
        self.notificationsEnabled = settings.notificationsEnabled
        self.notificationsReminderTime = settings.reminderTime
        self.appVersion = settings.appVersion
        self.deviceName = settings.deviceName
    }
}
