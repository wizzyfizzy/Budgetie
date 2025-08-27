//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

/// Centralized UserDefaults storage for the app.
/// Keeps all keys and provides typed accessors.

extension UserDefaults {
    public enum Keys {
        // MARK: Onboarding
        public static let isOnboardingCompletedKey = "isOnboardingCompleted"
        
        // MARK: User Profile
        public static let isDarkModeEnabledKey = "isDarkModeEnabled"
        public static let appLanguageKey = "appLanguage"
        public static let notificationsEnabledKey = "notificationsEnabled"
        public static let reminderTimeKey = "reminderTime"
    }
    
    // Delete all useerDefaults
    public func clearAll() {
            if let bundle = Bundle.main.bundleIdentifier {
                removePersistentDomain(forName: bundle)
            }
            synchronize()
        }
    
    /// Stores or retrieves if user completed the onboarding
    public var isOnboardingCompleted: Bool {
        get {
            bool(forKey: Keys.isOnboardingCompletedKey)
        }
        set {
            set(newValue, forKey: Keys.isOnboardingCompletedKey)
        }
    }
    
    /// Stores or retrieves if dark mode is enabled flag.
    public var isDarkModeEnabled: Bool {
        get {
            bool(forKey: Keys.isDarkModeEnabledKey)
        }
        set {
            set(newValue, forKey: Keys.isDarkModeEnabledKey)
        }
    }    
    
    /// Stores or retrieves the selected language ("EN" / "GR" κλπ).
    public var appLanguage: String {
        get {
            string(forKey: Keys.appLanguageKey) ?? Locale.current.language.languageCode?.identifier ?? "en"
        }
        set {
            set(newValue, forKey: Keys.appLanguageKey)
        }
    }
    
    /// Stores or retrieves if Notifications are enabled flag.
    public var notificationsEnabled: Bool {
        get {
            bool(forKey: Keys.notificationsEnabledKey)
        }
        set {
            set(newValue, forKey: Keys.notificationsEnabledKey)
        }
    }    
    
    /// Stores or retrieves the date of reminder
    public var reminderTime: Date {
        get {
            object(forKey: Keys.reminderTimeKey) as? Date ?? Date()
        }
        set {
            set(newValue, forKey: Keys.reminderTimeKey)
        }
    }
}
