//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

public extension View {
    /// Applies a reusable shadow to the view using a ShadowToken.
    func shadow(_ token: ShadowToken) -> some View {
        self.shadow(
            color: Color.black.opacity(token.opacity),
            radius: token.radius,
            x: token.tokenX,
            y: token.tokenY
        )
    }
}
