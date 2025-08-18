//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import AppNavigationAPI
import BTSubscriptionsAPI
import SwiftUI

/// Provides navigation registration for the My Budget feature.
public enum SubscriptionsNavigationViewProvider {
    
    /// Registers the MyBudget view in the given navigation registry.
    /// - Parameter registry: The shared navigation registry where views are stored.
    public static func register(in registry: NavigationRegistryProtocol) {
        // The builder closure is @escaping internally in the registry because
        // it will be stored and called later when the navigation is triggered.
        registry.registerView(SubscriptionsNavData.self) { _ in
            AnyView(SubscriptionsView())
        }
    }
}

public final class SubscriptionsViewBuilderImpl: SubscriptionsViewBuilder {
    public init() {}

    public func buildView(data: SubscriptionsNavData?) -> AnyView {
        AnyView(SubscriptionsView())
    }
}
