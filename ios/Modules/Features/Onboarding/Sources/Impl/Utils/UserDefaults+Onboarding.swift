//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let isOnboardingCompletedKey = "isOnboardingCompleted"
    }
    
    var isOnboardingCompleted: Bool {
        get {
            bool(forKey: Keys.isOnboardingCompletedKey)
        }
        set {
            set(newValue, forKey: Keys.isOnboardingCompletedKey)
        }
    }
}
