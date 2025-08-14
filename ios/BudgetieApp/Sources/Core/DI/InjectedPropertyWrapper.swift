//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

/// Resolves the injected type using the global `HCAppDI.shared` resolver.
@propertyWrapper
struct Injected<T> {
    private var value: T

    init() {
        value = BTAppDI.shared.resolve()
    }

    public var wrappedValue: T { value }
}
