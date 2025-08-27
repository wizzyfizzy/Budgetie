//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Combine
import AuthAPI
import Foundation
import AppLogging
import UIKit
import UIComponents

public final class ProfileVM: ObservableObject {
    // MARK: - Dependencies
    @Injected private var isLoggedInUC: IsLoggedInUC
    @Injected private var getUserSessionUC: GetUserSessionUC
    @Injected private var logoutUserUC: LogoutUserUC
    @Injected private var logger: BTLogger
//    @Injected private var updateDarkModeUC: UpdateDarkModeUC
//    @Injected private var updateLanguageUC: UpdateLanguageUC
//    @Injected private var updateNotificationsUC: UpdateNotificationSettingsUC
//    @Injected private var trackEventUC: TrackEventUC
    
    // MARK: - State
    @Published public private(set) var isLoggedIn: Bool = false
    @Published public private(set) var userData: UserData?
    
    @Published var isDarkMode: Bool {
        didSet {
            userDefaults.isDarkModeEnabled = isDarkMode
        }
    }
    
    @Published var language: String {
        didSet {
            userDefaults.appLanguage = language
        }
    }
    
    @Published public var notificationsEnabled: Bool {
        didSet {
            userDefaults.notificationsEnabled = notificationsEnabled
        }
    }
    
    @Published public var notificationsReminderTime: Date {
        didSet {
            userDefaults.reminderTime = notificationsReminderTime
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let fileName = "ProfileVM"
    private let userDefaults: UserDefaults

    // MARK: - Initialization
    public init() {
        self.userDefaults = UserDefaults.standard
        self.isDarkMode = userDefaults.isDarkModeEnabled
        self.language = userDefaults.appLanguage
        self.notificationsEnabled = userDefaults.notificationsEnabled
        self.notificationsReminderTime = userDefaults.reminderTime

        self.isLoggedIn = isLoggedInUC.execute()
        self.userData = getUserSessionUC.execute()

        setupAuthBindings()
    }
    
    // MARK: - Public
    func trackView() {
        logger.log(.debug, fileName: fileName, "TrackingView: \(TrackingView.profileScreen)")
    }
    
    public func trackTap(_ item: String) {
//        trackEventUC.execute(event: item)
    }
    
    public func onTapLogout() {
        // Alert first
        //        logoutUserUC.execute()
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
}
