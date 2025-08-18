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
   case myBudgetScreen = "MyBudget_Screen"
   case subscriptionsScreen = "Subscriptions_Screen"
   case transactionsScreen = "Transactions_Screen"
   case profileScreen = "Profile_Screen"
}
