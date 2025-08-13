//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

// sourcery: AutoMockable
/// A Use Case for triggering navigation actions from anywhere in the app,
/// without directly coupling to SwiftUI views or navigation APIs.
///
/// This protocol abstracts the navigation mechanism so that:
/// - Feature modules don't need to know about SwiftUI's `NavigationStack` or `.sheet`
/// - Navigation can be tested independently from UI code
/// - Navigation screens can be registered dynamically at app startup
///
/// **Usage:**
/// ```swift
/// navigateToUC.execute(data: MyFeatureNavData(id: UUID()), type: .push)
/// navigateToUC.execute(data: SettingsNavData(), type: .sheet)
/// ```
///
/// - Important: The `data` must conform to `NavigationData` and have a matching view registered
///   in the `NavigationRegistry` via a corresponding `NavigationViewProvider`.
///
/// - Parameters:
///   - data: A type conforming to `NavigationData` that represents the target screen and any parameters.
///   - type: The navigation style to use (e.g., `.push` or `.sheet`).
public protocol AppNavigateToUC {
    func execute(data: NavigationData, type: NavigationType)
}
