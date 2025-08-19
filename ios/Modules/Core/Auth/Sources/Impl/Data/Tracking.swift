//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
 
/// Represents the different screens or views that can be tracked.
///
/// Used to log when a specific screen is shown to the user.
/// For example, when the onboarding flow starts.
///
enum TrackingView: String {
    case authLoginScreen = "LoginScreen"
}

/// Represents user actions that can be tracked.
///
/// These values indicate events triggered by user interactions,
/// such as tapping a button, completing the onboarding, or
/// automatically advancing due to a timer.
enum TrackingAction: String {
    case tapLogin = "Tap.Login"
    case tapCancel = "Tap.Cancel"
}

/// Represents contextual values that can be attached to a tracked event.
///
/// These values provide additional metadata, such as the
/// current onboarding step where the action occurred.
enum TrackingValue: String {
    case userId
}
