//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI
 
// sourcery: AutoMockable
/// Repository interface responsible for managing profile settings persistence.
/// Abstracts away the underlying storage (e.g., UserDefaults, database, or remote API).
protocol ProfileSettingsRepo {
    
    /// Retrieves the current profile settings.
    /// - Returns: A `ProfileSettings` object containing all persisted values.
    func getSettings() -> ProfileSettings
    
    /// Updates the dark mode preference.
    /// - Parameter enabled: Boolean flag indicating if dark mode is enabled.
    func updateDarkMode(_ enabled: Bool)
    
    /// Updates the preferred application language.
    /// - Parameter language: The ISO code of the language (e.g., `"en"`, `"gr"`).
    func updateLanguage(_ language: String)
    
    /// Updates the notifications preference.
    /// - Parameter enabled: Boolean flag indicating if notifications are enabled.
    func updateNotifications(_ enabled: Bool)
    
    /// Updates the reminder notification time.
    /// - Parameter date: The `Date` object representing the reminder time.
    func updateReminderTime(_ date: Date)
}

final class ProfileSettingsRepoImpl: ProfileSettingsRepo {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func getSettings() -> ProfileSettings {
        ProfileSettings(
            isDarkMode: defaults.isDarkModeEnabled,
            language: defaults.appLanguage,
            notificationsEnabled: defaults.notificationsEnabled,
            reminderTime: defaults.reminderTime,
            appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0",
            deviceName: UIDevice.current.name
        )
    }
    
    public func updateDarkMode(_ enabled: Bool) {
        defaults.isDarkModeEnabled = enabled
    }
    
    public func updateLanguage(_ language: String) {
        defaults.appLanguage = language
    }
    
    public func updateNotifications(_ enabled: Bool) {
        defaults.notificationsEnabled = enabled
    }
    
    public func updateReminderTime(_ date: Date) {
        defaults.reminderTime = date
    }
}
