//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

/// A reusable shadow token for SwiftUI views.
public struct ShadowToken {
    public let radius: CGFloat
    public let tokenX: CGFloat
    public let tokenY: CGFloat
    public let opacity: Double

    public init(radius: CGFloat, tokenX: CGFloat, tokenY: CGFloat, opacity: Double) {
        self.radius = radius
        self.tokenX = tokenX
        self.tokenY = tokenY
        self.opacity = opacity
    }

    // MARK: - Standard Shadow Tokens
    public static let small = ShadowToken(
        radius: CornerRadius.spaceXS,
        tokenX: .zero,
        tokenY: 1,
        opacity: Color.Opacity.small
    )

    public static let medium = ShadowToken(
        radius: CornerRadius.spaceS,
        tokenX: .zero,
        tokenY: 2,
        opacity: Color.Opacity.medium
    )

    public static let large = ShadowToken(
        radius: CornerRadius.spaceM,
        tokenX: .zero,
        tokenY: 4,
        opacity: Color.Opacity.large
    )

    public static let card = ShadowToken(
        radius: CornerRadius.spaceS,
        tokenX: .zero,
        tokenY: 2,
        opacity: Color.Opacity.card
    )

    // MARK: - Pressed State Shadows
    public static let smallPressed = ShadowToken(
        radius: CornerRadius.spaceXS/2,
        tokenX: .zero,
        tokenY: 1,
        opacity: Color.Opacity.small
    )

    public static let mediumPressed = ShadowToken(
        radius: CornerRadius.spaceS/2,
        tokenX: .zero,
        tokenY: 1,
        opacity: Color.Opacity.medium
    )

    public static let largePressed = ShadowToken(
        radius: CornerRadius.spaceL/2,
        tokenX: .zero,
        tokenY: 2,
        opacity: Color.Opacity.large
    )

    public static let cardPressed = ShadowToken(
        radius: CornerRadius.spaceS/2,
        tokenX: .zero,
        tokenY: 1,
        opacity: Color.Opacity.card
    )
}
