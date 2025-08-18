//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import AppNavigationAPI
import BTProfileAPI
import SwiftUI

/// Provides navigation registration for the My Budget feature.
public enum ProfileNavigationViewProvider {
    
    /// Registers the Profile view in the given navigation registry.
    /// - Parameter registry: The shared navigation registry where views are stored.
    public static func register(in registry: NavigationRegistryProtocol) {
        // The builder closure is @escaping internally in the registry because
        // it will be stored and called later when the navigation is triggered.
        registry.registerView(ProfileNavData.self) { _ in
            AnyView(ProfileView())
        }
    }
}

public final class ProfileViewBuilderImpl: ProfileViewBuilder {
    public init() {}

    public func buildView(data: ProfileNavData?) -> AnyView {
        AnyView(ProfileView())
    }
}
