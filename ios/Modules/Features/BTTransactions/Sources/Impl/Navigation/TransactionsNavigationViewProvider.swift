//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import AppNavigationAPI
import BTTransactionsAPI
import SwiftUI

/// Provides navigation registration for the Transactions feature.
public enum TransactionsNavigationViewProvider {
    
    /// Registers the Transactions view in the given navigation registry.
    /// - Parameter registry: The shared navigation registry where views are stored.
    public static func register(in registry: NavigationRegistryProtocol) {
        // The builder closure is @escaping internally in the registry because
        // it will be stored and called later when the navigation is triggered.
        registry.registerView(TransactionsNavData.self) { _ in
            AnyView(TransactionsView())
        }
    }
}

public final class TransactionsViewBuilderImpl: TransactionsViewBuilder {
    public init() {}

    public func buildView(data: TransactionsNavData?) -> AnyView {
        AnyView(TransactionsView())
    }
}
