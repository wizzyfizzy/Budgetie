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
    case profileScreen = "Profile Screen"
    case profileFAQScreen = "FAQ Screen"
    case profilePrivacyPolicyScreen = "Privacy Policy Screen"
    case profileTermsOfServiceScreen = "Terms Of Service Screen"
}

/// Represents user actions that can be tracked.
///
/// These values indicate events triggered by user interactions
enum TrackingAction: String {
    case tapDarkMode = "Tap.Change.DarkMode"
    case tapLanguage = "Tap.Change.Language"
    case tapFAQ = "Tap.FAQ"
    case tapPrivacyPolicy = "Tap.PrivacyPolicy"
    case tapTermsOfService = "Tap.TermsOfService"
    case tapLogout = "Tap.Logout"
    case tapLogoutCompleted = "Tap.Logout.Completed"
}

/// Represents contextual values that can be attached to a tracked event.
///
/// These values provide additional metadata
enum TrackingValue: String {
    case darkModeOn = "DarkMode is On"
    case darkModeOff = "DarkMode is Off"
    case languageEN = "Language is en"
    case languageEL = "Language is el"
}
