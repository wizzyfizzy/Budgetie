//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppNavigationAPI
import SwiftUI

/// Navigation data object for the Subscriptions view.
/// Used by the navigation system to trigger builder to `SubscriptionsView`.
public struct SubscriptionsNavData: NavigationData {
    public let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
}

public protocol SubscriptionsViewBuilder {
    func buildView(data: SubscriptionsNavData?) -> AnyView
}

public enum SubscriptionsNavigationViewProvider {
    private static var builder: SubscriptionsViewBuilder?

    public static func register(builder: SubscriptionsViewBuilder) {
        self.builder = builder
    }

    public static func buildView(data: SubscriptionsNavData? = nil) -> AnyView {
        guard let builder else { return AnyView(EmptyView()) }
        return builder.buildView(data: data)
    }
}
