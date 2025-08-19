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
        public static let isOnboardingCompletedKey = "isOnboardingCompleted"
        public static let lastEmailKey = "lastEmail"
        public static let rememberMeKey = "rememberMe"
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
    
    /// Stores or retrieves the last used email for login.
    public static var lastEmail: String? {
        get { UserDefaults.standard.string(forKey: Keys.lastEmailKey) }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.lastEmailKey) }
    }
    
    /// Stores or retrieves the Remember Me flag.
    public static var rememberMe: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.rememberMeKey) }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.rememberMeKey) }
    }
}
