//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI

// sourcery: AutoMockable
/// Use case for retrieving the current profile settings.
/// Provides a single source of truth for settings stored in the repository.
protocol GetProfileSettingsUC {
    /// Executes the use case to fetch the profile settings.
    /// - Returns: A `ProfileSettings` object containing the persisted values.
    func execute() -> ProfileSettings
}

final class GetProfileSettingsUCImpl: GetProfileSettingsUC {
    @Injected private var repo: ProfileSettingsRepo
    
    func execute() -> ProfileSettings {
        repo.getSettings()
    }
}
