//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
 
// sourcery: AutoMockable
protocol ProfileSettingsRepository {
    func getSettings() -> ProfileSettings
    func updateDarkMode(_ enabled: Bool)
    func updateLanguage(_ language: String)
    func updateNotifications(_ enabled: Bool)
    func updateReminderTime(_ date: Date)
}

final class ProfileSettingsRepositoryImpl: ProfileSettingsRepository {
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func getSettings() -> ProfileSettings {
        Settings(
            isDarkMode: defaults.isDarkMode,
            language: defaults.string(forKey: "appLanguage") ?? "en",
            notificationsEnabled: defaults.bool(forKey: "notificationsEnabled"),
            reminderTime: defaults.object(forKey: "reminderTime") as? Date ?? Date()
        )
    }
    
    public func updateDarkMode(_ enabled: Bool) {
        defaults.set(enabled, forKey: "darkModeEnabled")
    }
    
    public func updateLanguage(_ language: String) {
        defaults.set(language, forKey: "appLanguage")
    }
    
    public func updateNotifications(_ enabled: Bool) {
        defaults.set(enabled, forKey: "notificationsEnabled")
    }
    
    public func updateReminderTime(_ date: Date) {
        defaults.set(date, forKey: "reminderTime")
    }
}
