//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import UIComponents

// sourcery: AutoMockable
/// Handles logging out the current user.
public protocol LogoutUserUC {
    /// Logouts the user - Clears the current user session.
    func execute()
}
