//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI
 
// sourcery: AutoMockable
/// Use case for updating the notifications preference.
/// Persists whether notifications are enabled or disabled.
protocol UpdateNotificationsUC {
    /// Executes the use case to update notification settings.
    /// - Parameter enabled: Boolean flag indicating if notifications are enabled.
    func execute(enabled: Bool)
}

final class UpdateNotificationsUCImpl: UpdateNotificationsUC {
    @Injected private var repo: ProfileSettingsRepo
    
    func execute(enabled: Bool) {
        repo.updateNotifications(enabled)
    }
}
