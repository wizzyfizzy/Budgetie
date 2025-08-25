//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging
import BTRestClientAPI

public struct Dependencies {
    public let logger: () -> BTLogger
    public let restClient: () -> HTTPClient
    
    public init(logger: @escaping () -> BTLogger,
                restClient: @escaping () -> HTTPClient) {
        self.logger = logger
        self.restClient = restClient
    }
}
