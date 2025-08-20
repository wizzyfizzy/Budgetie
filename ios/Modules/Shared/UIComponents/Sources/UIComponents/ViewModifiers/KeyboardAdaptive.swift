//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import Combine

/// A view modifier that adjusts the bottom padding of a view when the keyboard appears or disappears.
/// This ensures that content is not hidden behind the keyboard.
struct KeyboardAdaptiveModifier: ViewModifier {
    
    /// The current height of the keyboard.
    @State private var keyboardHeight: CGFloat = 0
    /// A Combine cancellable for the keyboard notification observers.
    private var cancellable: AnyCancellable?
    
    init() {}
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .animation(.easeOut(duration: 0.25), value: keyboardHeight)
            .onReceive(
                Publishers.Merge(
                    NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
                        .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                        .map { $0.height },
                    
                    NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                        .map { _ in CGFloat(0) }
                )
            ) { height in
                self.keyboardHeight = height
            }
    }
}

public extension View {
    /// Applies a modifier that automatically adjusts view padding when the keyboard appears or disappears.
    /// - Returns: A view that moves up or down with the keyboard to prevent being obscured.
    func keyboardAdaptive() -> some View {
        self.modifier(KeyboardAdaptiveModifier())
    }
}
