//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

public extension String {
    
    /// Returns the localized version of the string from a given localization table.
    ///
    /// This is a generic helper that can be used throughout the app to fetch
    /// localized strings, reducing boilerplate and ensuring consistency.
    ///
    /// - Parameters:
    ///   - tableName: The name of the strings table or catalog. Defaults to `"Localization"`.
    ///   - bundle: The bundle in which the strings file is located. Defaults to `.main`.
    ///   - comment: A developer comment describing the usage of the string. Defaults to an empty string.
    /// - Returns: The localized version of the string according to the current device language.
    func localized(
        tableName: String = "Localization",
        bundle: Bundle = .main,
        comment: String = ""
    ) -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, comment: comment)
    }
}
