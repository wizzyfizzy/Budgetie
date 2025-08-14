//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI

/// A type-erased SwiftUI view container with a unique identity.
///
/// `AnyViewWrapper` is used to store `AnyView` instances in collections
/// (e.g., `@Published var path: [AnyViewWrapper]` for NavigationStack
/// or `@Published var sheetView: AnyViewWrapper?` for modals)
/// while maintaining `Identifiable` and `Hashable` conformance.
///
/// This allows SwiftUI to:
/// - Track view instances in navigation paths.
/// - Correctly identify and update views when state changes.
/// - Present sheets and modals with the `.sheet(item:)` API, which requires `Identifiable`.
///
/// **Why not use `AnyView` directly?**
/// - `AnyView` does not conform to `Identifiable` or `Hashable`.
/// - Without an ID, SwiftUI cannot distinguish between different navigation items.
///
/// **Example Usage:**
/// ```swift
/// // Wrapping a SwiftUI view for navigation
/// let profileView = AnyView(ProfileView(userID: "123"))
/// let wrapper = AnyViewWrapper(view: profileView)
/// path.append(wrapper)
///
/// // Using with a sheet
/// sheetView = AnyViewWrapper(view: SettingsView())
/// ```
///
/// - Note: Equality (`==`) and hashing are based on the wrapper's `id`
///   (a UUID generated on creation), not on the underlying view.
struct AnyViewWrapper: Identifiable, Hashable {
    let id = UUID()
    let view: AnyView

    static func == (lhs: AnyViewWrapper, rhs: AnyViewWrapper) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
