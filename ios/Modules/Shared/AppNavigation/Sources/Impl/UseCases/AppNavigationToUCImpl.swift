//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppNavigationAPI
import SwiftUI

public final class AppNavigateToUCImpl: AppNavigateToUC {
    private let navigationHandler: (NavigationData, NavigationType) -> Void

    public init(navigationHandler: @escaping (NavigationData, NavigationType) -> Void) {
        self.navigationHandler = navigationHandler
    }

    public func execute(data: NavigationData, type: NavigationType) {
        navigationHandler(data, type)
    }
}
