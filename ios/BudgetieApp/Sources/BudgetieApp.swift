//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

@main
struct BudgetieApp: App {
    
    init() {
        BTAppDI.setUp()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(navContext: BTAppDI.shared.resolve(NavigationContext.self))
        }
    }
}
