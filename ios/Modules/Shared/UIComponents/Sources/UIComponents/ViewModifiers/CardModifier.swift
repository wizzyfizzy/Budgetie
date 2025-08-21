//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import SwiftUI

public struct CardModifier: ViewModifier {
    public var cornerRadius: CGFloat = CornerRadius.spaceXL
    
    public init() { }

    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.spaceXL, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .shadow(.medium)
            )
            .padding(Spacing.spaceXL)
    }
}
