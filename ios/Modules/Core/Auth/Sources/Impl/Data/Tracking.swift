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
    case authSignInScreen = "SignInScreen"
    case authSignUpScreen = "SignUpScreen"
    case authForgotPasswordScreen = "ForgotPasswordScreen"
}

/// Represents user actions that can be tracked.
///
/// These values indicate events triggered by user interactions,
/// such as tapping a button, completing login, completed sign in
enum TrackingAction: String {
    case tapSignIn = "Tap.SignIn"
    case tapForgotPassword = "Tap.ForgotPassword"
    case tapResetPassword = "Tap.tapResetPassword"
    case tapSignInWithApple = "Tap.SignInWithApple"
    case tapCreateAccount = "Tap.CreateAccount"
    case tapSignUp = "Tap.SignUp"
    case completedSignIn = "Complete.SignIn"
    case completedSignUp = "Complete.SignUp"
}

/// Represents contextual values that can be attached to a tracked event.
///
/// These values provide additional metadata, such as the userId or email
enum TrackingValue: String {
    case userId
    case email
}
