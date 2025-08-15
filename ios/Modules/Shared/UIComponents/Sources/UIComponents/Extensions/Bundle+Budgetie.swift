//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

public extension Bundle {
    static var module: Bundle {
        return Bundle(for: BundleToken.self)
    }

    private final class BundleToken {}
}
