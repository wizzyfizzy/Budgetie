//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

struct PagerItem: Identifiable {
    var id: Int {
        return index
    }
    
    let index: Int
    let size: Double
    let isSelected: Bool
    
    init(index: Int, size: Double, isSelected: Bool) {
        self.index = index
        self.size = size
        self.isSelected = isSelected
    }
}

public class PagerVM: ObservableObject {
    @Published public var numberOfPages: Int = 0
    @Published public var currentPage: Int = 0 {
        didSet { updatePagerItems() }
    }
    @Published var pagerItems: [PagerItem] = []
    
    static let defaultIconSize = 5.0
    static let selectedIconSize = 7.0
    
    public init(numberOfPages: Int = 3) {
        self.numberOfPages = 3
        buildItems()
    }
    
    private func updatePagerItems() {
        buildItems()
    }
    
    private func buildItems() {
        var items: [PagerItem] = []
        for index in 0..<numberOfPages {
            let isSelected = currentPage == index
            items.append(
                PagerItem(
                    index: index,
                    size: isSelected ? PagerVM.selectedIconSize : PagerVM.defaultIconSize,
                    isSelected: isSelected
                )
            )
        }
        pagerItems = items
    }
    
}
