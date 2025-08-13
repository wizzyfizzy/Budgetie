//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

// MARK: - Public Protocols

/// Marker protocol for navigation data.
/// Each screen that wants to be navigated to should have its own `NavigationData` type.
public protocol NavigationData {}

/// Defines the supported navigation types.
public enum NavigationType {
    case push
    case sheet
}
 
