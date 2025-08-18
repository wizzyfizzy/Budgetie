//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppNavigationAPI
import SwiftUI

/// Navigation data object for the Transactions view.
/// Used by the navigation system to trigger builder to `TransactionsView`.
public struct TransactionsNavData: NavigationData {
    public let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
}

public protocol TransactionsViewBuilder {
    func buildView(data: TransactionsNavData?) -> AnyView
}

public enum TransactionsNavigationViewProvider {
    private static var builder: TransactionsViewBuilder?

    public static func register(builder: TransactionsViewBuilder) {
        self.builder = builder
    }

    public static func buildView(data: TransactionsNavData? = nil) -> AnyView {
        guard let builder else { return AnyView(EmptyView()) }
        return builder.buildView(data: data)
    }
}
