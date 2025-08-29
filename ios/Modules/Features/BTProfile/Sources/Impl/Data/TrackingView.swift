//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
 
/// Represents the different screens or views that can be tracked.
///
/// Used to log when a specific screen is shown to the user.
///
enum TrackingView: String {
    case profileLoggedInScreen = "Profile Screen - User is Logged in"
    case profileLoggedOutScreen = "Profile Screen - User is Logged out"
    case profileFAQScreen = "FAQ Screen"
    case profilePrivacyPolicyScreen = "Privacy Policy Screen"
    case profileTermsOfServiceScreen = "Terms Of Service Screen"
}

/// Represents user actions that can be tracked.
///
/// These values indicate events triggered by user interactions
enum TrackingAction: String {
    case tapDarkMode = "Toggle.Settings.DarkMode"
    case tapLanguage = "Tap.Settings.Language"
    case tapEnableNotifications = "Toggle.Settings.Enable.Notifications"
    case tapReminderTimer = "Tap.Settings.Reminder.Timer"
    case tapFAQ = "Tap.Settings.FAQ"
    case tapPrivacyPolicy = "Tap.Settings.PrivacyPolicy"
    case tapTermsOfService = "Tap.Settings.TermsOfService"
    case tapLogout = "Tap.Settings.Logout"
    case tapLogoutCompleted = "Tap.Settings.Logout.Completed"
    case tapLogoutCancelled = "Tap.Settings.Logout.Cancelled"
    case tapLogin = "Tap.Settings.Login"
}

/// Represents contextual values that can be attached to a tracked event.
///
/// These values provide additional metadata
enum TrackingValue: String {
    case darkModeIs = "DarkMode is"
    case languageIs = "Language is"
    case enableNotificationsAre = "Enable Notifications are "
    case reminderTimer = "reminder Timer is set at"
}
