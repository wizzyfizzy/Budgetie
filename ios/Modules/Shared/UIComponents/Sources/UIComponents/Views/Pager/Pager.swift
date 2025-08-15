//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

/// A horizontal pager indicator with dots representing pages.
///
/// The currently selected page is highlighted with a larger, colored dot.
/// The `Pager` observes its `PagerVM` view model for updates.
///
/// Example usage:
/// ```swift
/// Pager(viewModel: PagerVM(numberOfPages: 4))
/// ```
///
/// - Parameters:
///   - pagerVM: The `PagerVM` view model that controls the pager's state.
///   
public struct Pager: View {
    
    @ObservedObject public var pagerVM: PagerVM
    
    public init(viewModel: PagerVM) {
        pagerVM = viewModel
    }
    
    @ViewBuilder
    public var body: some View {
        if !pagerVM.pagerItems.isEmpty {
            HStack(spacing: Spacing.spaceS) {
                ForEach(pagerVM.pagerItems) { item in
                   Circle()
                        .frame(width: item.size, height: item.size)
                        .scaledToFit()
                        .foregroundColor(item.isSelected ? .btOrange : .btLightGrey)
                }
                .animation(.default, value: pagerVM.currentPage)
            }
        }
    }
}
