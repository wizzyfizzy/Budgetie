//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

/// A reusable SwiftUI button with gradient background, optional image, and built-in pressed/disabled states.
///
/// It supports:
/// - Customizable corner radius
/// - Micro shadow
/// - Disabled state (gray)
/// - Pressed state
/// - Optional image next to the label
///
/// Example usage:
///
/// GradientButton(
///     text: "Start",
///     image: Image(systemName: "play.fill"),
///     isEnabled: $canTapButton
/// ) {
///     doSomething()
/// }
///
public struct GradientButton: View {
    
    /// Binding to enable or disable the button
    @Binding var isEnabled: Bool
    
    /// Internal state for pressed effect
    @State private var isPressed: Bool = false
    
    /// Action to perform when the button is tapped
    let action: () -> Void
    
    /// Optional image displayed next to the label
    let image: Image?
    
    /// Optional image displayed next to the label
    let text: String
    
    /// Corner radius of the button
    let cornerRadius: CGFloat = CornerRadius.spaceM
    
    public init(isEnabled: Binding<Bool> = .constant(true),
                image: Image? = nil,
                text: String,
                action: @escaping () -> Void) {
        self._isEnabled = isEnabled
        self.action = action
        self.text = text
        self.image = image
    }
    
    public var body: some View {
        let background = LinearGradient(colors: gradientColors,
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
        
        Button(action: {
            if isEnabled {
                action()
            }
        }, label: {
            HStack(spacing: Spacing.spaceS) {
                if let image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: IconSize.spaceM, height: IconSize.spaceM)
                        .foregroundColor(.btWhite)
                }
                Text(text)
                    .font(.appButton)
                    .foregroundColor(.btWhite)
            }
            .frame(maxWidth: .infinity)
            .frame(height: ButtonSize.heightMd)
            .background(background)
            .cornerRadius(cornerRadius)
            .shadow(.medium)
            .scaleEffect(isPressed ? 0.98 : 1.0)
        })
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle()) // disable the default opacity effect when button is clicked
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    // User is pressing the button → activate pressed state
                    if isEnabled { isPressed = true }
                }
                .onEnded { _ in
                    // User released the button → deactivate pressed state
                    isPressed = false
                }
        )
    }
    
    private var gradientColors: [Color] {
        if !isEnabled {
            return [Color.btGray, Color.btLightGrey]
        } else {
            return [Color.btDarkGreen, Color.btGreen]
        }
    }
}
