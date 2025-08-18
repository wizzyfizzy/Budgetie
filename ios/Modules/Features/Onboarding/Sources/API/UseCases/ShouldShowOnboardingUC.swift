//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

// sourcery: AutoMockable
/// A use case that determines whether the onboarding flow should be displayed.
///
/// This use case typically checks persistent storage (e.g. `UserDefaults`)
/// to see if the onboarding has already been completed by the user.
///
/// - Returns: `Bool` if onboarding should be shown or not
///
public protocol ShouldShowOnboardingUC {
    func execute() -> Bool
}
