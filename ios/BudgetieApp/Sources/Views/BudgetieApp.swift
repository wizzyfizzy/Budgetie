//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

@main
struct BudgetieApp: App {
    @State private var showLaunch = true
    @StateObject var appState = AppState()

    init() {
        BTAppDI.setUp()
    }
    
    var body: some Scene {
        WindowGroup {
            if showLaunch {
                LaunchScreenView(showLaunch: $showLaunch)
            } else {
                HomeView(navContext: BTAppDI.shared.resolve(NavigationContext.self))
                    .environmentObject(appState)
            }
        }
    }
}
