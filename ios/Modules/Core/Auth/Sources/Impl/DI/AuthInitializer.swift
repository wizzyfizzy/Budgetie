//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

/// Module Initializer
public final class AuthInitializer {
    /// Module Initializer
    public static func initialize(empty: Bool = false, dependencies: Dependencies) {
        if !(AuthDI.shared is AuthDI) {
            AuthDI.shared = AuthDI(empty: empty,
                                               dependencies: dependencies)
        }
    }
}
