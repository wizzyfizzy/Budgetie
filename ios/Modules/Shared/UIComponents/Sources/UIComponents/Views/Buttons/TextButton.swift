//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

/// A reusable SwiftUI text button with no background, optional image, and built-in pressed/disabled states.
///
/// It supports:
/// - Disabled state
/// - Pressed state
/// - Optional image next to the label
///
/// Example usage:
///
/// TextButton(
///     text: "Start",
///     image: Image(systemName: "play.fill"),
///     isEnabled: $canTapButton
/// ) {
///     doSomething()
/// }
///
public struct TextButton: View {
    
    /// Binding to enable or disable the button
    @Binding var isEnabled: Bool  
    
    /// Binding to show or not the loader
    @Binding var isLoading: Bool
    
    /// Internal state for pressed effect
    @State private var isPressed: Bool = false
    
    /// Action to perform when the button is tapped
    let action: () -> Void
    
    /// Optional image displayed next to the label
    let image: Image?
    
    /// Text displayed of the label
    let text: String
    
    /// Color of image and label
    let color: Color
    
    public init(isEnabled: Binding<Bool> = .constant(true),
                isLoading: Binding<Bool> = .constant(false),
                image: Image? = nil,
                text: String,
                color: Color = .btGray,
                action: @escaping () -> Void) {
        self._isEnabled = isEnabled
        self._isLoading = isLoading
        self.action = action
        self.text = text
        self.image = image
        self.color = color
    }
    
    public var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }, label: {
            HStack(spacing: Spacing.spaceS) {
                if isLoading {
                    ProgressView().padding(.trailing, Spacing.spaceS)
                }
                if let image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: IconSize.spaceM, height: IconSize.spaceM)
                        .foregroundColor(color)
                }
                Text(text)
                    .font(.appButton)
                    .foregroundColor(color)
            }
            .frame(height: ButtonSize.heightMd)
            .background(Color.clear)
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
}
