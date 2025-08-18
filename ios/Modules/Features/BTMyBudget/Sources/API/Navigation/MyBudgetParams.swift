//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppNavigationAPI
import SwiftUI

/// Navigation data object for the MyBudget view.
/// Used by the navigation system to trigger builder to `MyBudgetView`.
public struct MyBudgetNavData: NavigationData {
    public let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
}

public protocol MyBudgetViewBuilder {
    func buildView(data: MyBudgetNavData?) -> AnyView
}

public enum MyBudgetNavigationViewProvider {
    private static var builder: MyBudgetViewBuilder?

    public static func register(builder: MyBudgetViewBuilder) {
        self.builder = builder
    }

    public static func buildView(data: MyBudgetNavData? = nil) -> AnyView {
        guard let builder else { return AnyView(EmptyView()) }
        return builder.buildView(data: data)
    }
}
