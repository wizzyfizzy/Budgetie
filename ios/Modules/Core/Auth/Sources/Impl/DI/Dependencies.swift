//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging
import BTRestClientAPI
import Foundation
import UIComponents

public struct Dependencies {
    let logger: () -> BTLogger
    let restClient: () -> HTTPClient
    let keyChain: SecureStore
    let userDefaults: UserDefaults

    public init(logger: @escaping () -> BTLogger,
                restClient: @escaping () -> HTTPClient,
                keyChain: SecureStore,
                userDefaults: UserDefaults) {
        self.logger = logger
        self.restClient = restClient
        self.keyChain = keyChain
        self.userDefaults = userDefaults
    }
}
