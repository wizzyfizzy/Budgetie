//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

/// A central registry responsible for mapping `NavigationData` types to SwiftUI views.
///
/// The `NavigationRegistryProtocol` is the backbone of the app's navigation system:
/// - It allows feature modules to register their navigation destinations without directly
///   depending on the main app.
/// - It ensures that navigation can be performed dynamically by looking up a `NavigationData`
///   type at runtime and returning its associated view.
///
/// **How it works:**
/// 1. At app startup (usually inside the DI container setup), each feature module calls
///    `registerView` to link a `NavigationData` type to a SwiftUI view builder.
/// 2. When a navigation action is triggered (via `AppNavigateToUC.execute`), the registry
///    uses `resolveView` to find and return the matching SwiftUI view.
///
/// **Example Registration:**
/// ```swift
/// registry.registerView(ProfileNavData.self) { data in
///     AnyView(ProfileView(userID: data.userID))
/// }
/// ```
///
/// **Example Resolution:**
/// ```swift
/// if let view = registry.resolveView(data: ProfileNavData(userID: "123")) {
///     // Push or present this view
/// }
/// ```
///
/// - Important: The `registerView` and `resolveView` functions must use the exact same `NavigationData` type.
///   If a type is not registered, navigation will silently fail.
///
/// - Parameters:
///   - type: The `NavigationData` type to register.
///   - builder: A closure that creates the SwiftUI view for the given `NavigationData` instance.
public protocol NavigationRegistryProtocol {
    /// Registers a SwiftUI view builder for a given `NavigationData` type.
    /// - Parameters:
    ///   - type: The `NavigationData` type to register.
    ///   - builder: A closure that creates the SwiftUI view for the given `NavigationData` instance.
    func registerView<Data: NavigationData>(_ type: Data.Type, builder: @escaping (Data) -> AnyView)
    
    /// Resolves the SwiftUI view for a given `NavigationData` instance.
    /// - Parameters:
    ///   - data: The `NavigationData` type to register.
    /// - Returns: The SwiftUI view for the given `NavigationData` instance.
    func resolveView<Data: NavigationData>(data: Data) -> AnyView?
}

/// Factory protocol for creating a NavigationRegistry instance.
public protocol NavigationRegistryFactory {
    static func make() -> NavigationRegistryProtocol
}
