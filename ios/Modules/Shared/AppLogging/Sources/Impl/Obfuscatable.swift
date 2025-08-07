//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

/// A protocol for sensitive values that can be obfuscated before logging.
public protocol Obfuscatable {
    /// Returns an obfuscated string that holds sensitive info
    ///
    /// - Returns: The obfuscated string
    func obfuscated() -> String
}
