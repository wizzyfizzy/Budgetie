//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import AppNavigationAPI
import BTMyBudgetAPI
import SwiftUI

/// Provides navigation registration for the My Budget feature.
public enum MyBudgetNavigationViewProvider {
    
    /// Registers the MyBudget view in the given navigation registry.
    /// - Parameter registry: The shared navigation registry where views are stored.
    public static func register(in registry: NavigationRegistryProtocol) {
        // The builder closure is @escaping internally in the registry because
        // it will be stored and called later when the navigation is triggered.
        registry.registerView(MyBudgetNavData.self) { _ in
            AnyView(MyBudgetView())
        }
    }
}

public final class MyBudgetViewBuilderImpl: MyBudgetViewBuilder {
    public init() {}

    public func buildView(data: MyBudgetNavData?) -> AnyView {
        AnyView(MyBudgetView())
    }
}
