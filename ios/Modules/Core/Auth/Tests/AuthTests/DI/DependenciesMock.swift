//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Auth
import AppLoggingMocks
import BTRestClientMocks
import Foundation
import UIComponents

extension Dependencies {
    static func mock() -> Dependencies {
        let suiteName = "AuthTests"
        let userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
        userDefaults.removePersistentDomain(forName: suiteName)
        return Dependencies(logger: { BTLoggerMock() },
                            restClient: { BTRestClientMocks() },
                            keyChain: KeychainSecureStoreMock(),
                            userDefaults: userDefaults)
    }
}
