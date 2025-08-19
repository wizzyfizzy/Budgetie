//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

public extension String {
    
    /// Checks if the string is in a valid email format.
    ///
    /// Uses a simple regex pattern to validate that the string
    /// follows the basic `username@domain.tld` structure.
    /// The check is case-insensitive, so both uppercase and lowercase
    /// characters are accepted.
    ///
    /// - Returns: `true` if the string is a valid email address,
    ///   otherwise `false`.
    var isValidEmail: Bool {
        let emailFormat = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailFormat)
        return predicate.evaluate(with: self)
    }
    
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
