//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppLogging

public struct Dependencies {
    public let logger: () -> BTLogger
    
    public init(logger: @escaping () -> BTLogger) {
        self.logger = logger
    }
}
