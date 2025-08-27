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
}
