//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging
import Foundation

public struct Dependencies {
    let logger: () -> BTLogger
    let userDefaults: UserDefaults

    public init(logger: @escaping () -> BTLogger,
                userDefaults: UserDefaults) {
        self.logger = logger
        self.userDefaults = userDefaults
    }
}
