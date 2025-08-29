//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI
 
// sourcery: AutoMockable
/// Use case for updating the reminder notification time.
/// Persists the new reminder time in the repository.
protocol UpdateReminderTimeUC {
    /// Executes the use case to update reminder time.
    /// - Parameter date: The `Date` object representing the reminder time.
    func execute(date: Date)
}

final class UpdateReminderTimeUCImpl: UpdateReminderTimeUC {
    @Injected private var repo: ProfileSettingsRepo
    
    func execute(date: Date) {
        repo.updateReminderTime(date)
    }
}
