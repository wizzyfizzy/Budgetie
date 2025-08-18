//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

/// A horizontal  Pager view that displays a row of dots representing pages or steps in a flow.
///
/// - Features:
///   - Highlights the current active page.
///   - Animates transitions when the current page changes.
///   - Fully reusable and can be bound to any external state (e.g., Onboarding ViewModel).

/// - Parameters:
///   - currentPage: Binding to the current active page.
///   - numberOfPages: Total number of pages.
///   
///   Example Usage:
///   Pager(currentPage: $viewModel.currentStep,
///        numberOfPages: viewModel.onboardingSteps.count)
///
public struct Pager: View {
    @Binding var currentPage: Int
    let numberOfPages: Int
    
    private let defaultIconSize: CGFloat = 5
    private let selectedIconSize: CGFloat = 7
    
    public init(currentPage: Binding<Int>, numberOfPages: Int) {
        _currentPage = currentPage
        self.numberOfPages = numberOfPages
    }
    
    public var body: some View {
        HStack(spacing: Spacing.spaceS) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .frame(width: currentPage == index ? selectedIconSize : defaultIconSize,
                           height: currentPage == index ? selectedIconSize : defaultIconSize)
                    .foregroundColor(currentPage == index ? .btOrange : .btLightGrey)
                    .animation(.default, value: currentPage)
            }
        }
    }
}
