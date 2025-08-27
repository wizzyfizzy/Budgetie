//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

/// Module Initializer
public final class BTProfileInitializer {
    /// Module Initializer
    public static func initialize(empty: Bool = false, dependencies: Dependencies) {
        if !(BTProfileDI.shared is BTProfileDI) {
            BTProfileDI.shared = BTProfileDI(empty: empty,
                                               dependencies: dependencies)
        }
    }
}
