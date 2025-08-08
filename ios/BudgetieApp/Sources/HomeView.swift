//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import AppLogging
import OnboardingAPI

struct HomeView: View {
    @Injected private var logger: BTLogger
    @Injected private var shouldShowOnboardingUC: ShouldShowOnboardingUC
    
    var body: some View {
        if shouldShowOnboardingUC.execute() {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, onboarding!")
            }
            .padding()
            .onAppear {
                logger.log(.debug, fileName: "ContentView", "Onboarding appeared ✅")
            }
        } else {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .onAppear {
                logger.log(.debug, fileName: "ContentView", "ContentView appeared ✅")
            }
        }
        
    }
}

#Preview {
    HomeView()
}
