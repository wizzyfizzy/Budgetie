//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

/// Module Initializer
public final class OnboardingInitializer {
    /// Module Initializer
    public static func initialize(empty: Bool = false, dependencies: Dependencies) {
        if !(OnboardingDI.shared is OnboardingDI) {
            OnboardingDI.shared = OnboardingDI(empty: empty,
                                               dependencies: dependencies)
        }
    }
}
