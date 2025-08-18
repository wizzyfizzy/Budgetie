//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import AppNavigationAPI
import SwiftUI

/// Navigation data object for the Profile view.
/// Used by the navigation system to trigger builder to `ProfileView`.
public struct ProfileNavData: NavigationData {
    public let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
}

public protocol ProfileViewBuilder {
    func buildView(data: ProfileNavData?) -> AnyView
}

public enum ProfileNavigationViewProvider {
    private static var builder: ProfileViewBuilder?

    public static func register(builder: ProfileViewBuilder) {
        self.builder = builder
    }

    public static func buildView(data: ProfileNavData? = nil) -> AnyView {
        guard let builder else { return AnyView(EmptyView()) }
        return builder.buildView(data: data)
    }
}
