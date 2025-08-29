//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI
 
// sourcery: AutoMockable
/// Use case for updating the dark mode preference.
/// Persists the chosen state in the repository.
protocol UpdateDarkModeUC {
    /// Executes the use case to update dark mode.
    /// - Parameter enabled: Boolean flag indicating if dark mode is enabled.
    func execute(enabled: Bool)
}

final class UpdateDarkModeUCImpl: UpdateDarkModeUC {
    @Injected private var repo: ProfileSettingsRepo
    
    func execute(enabled: Bool) {
        repo.updateDarkMode(enabled)
    }
}
