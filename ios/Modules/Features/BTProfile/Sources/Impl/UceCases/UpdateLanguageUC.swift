//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI
 
// sourcery: AutoMockable
/// Use case for updating the preferred application language.
/// Persists the new language selection in the repository.
protocol UpdateLanguageUC {
    /// Executes the use case to update the language.
    /// - Parameter language: The ISO code of the language (e.g., `"en"`, `"el"`).
    func execute(language: String)
}

final class UpdateLanguageUCImpl: UpdateLanguageUC {
    @Injected private var repo: ProfileSettingsRepo
    
    func execute(language: String) {
        repo.updateLanguage(language)
    }
}
