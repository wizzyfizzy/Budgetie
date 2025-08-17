//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import AppLogging
import OnboardingAPI
import AppNavigationAPI
import UIComponents

struct HomeView: View {
    @Injected private var logger: BTLogger
    @Injected private var shouldShowOnboardingUC: ShouldShowOnboardingUC
    @Injected private var navigateToUC: AppNavigateToUC
    
    @ObservedObject var navContext: NavigationContext
    @State private var isButtonEnabled: Bool = true

    var body: some View {
        NavigationStack(path: $navContext.path) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundColor(.btGreen)
                .navigationDestination(for: AnyViewWrapper.self) { wrapper in
                    wrapper.view
                }
            GradientButton(isEnabled: $isButtonEnabled,
                            text: "Let's start",
                           action: {
                logger.log(.debug, fileName: "HomeView", "GradientButton is clicked")
            })
            .padding(.horizontal, Spacing.spaceL)
        }
        .onAppear {
            if shouldShowOnboardingUC.execute() {
//                navigateToUC.execute(data: OnboardingAPI.OnboardingNavData(), type: .push)
                navigateToUC.execute(data: OnboardingAPI.OnboardingNavData(), type: .sheet)
            }
        }
        .fullScreenCover(item: $navContext.sheetView) { wrapper in
            wrapper.view
                .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    HomeView(navContext: BTAppDI.shared.resolve(NavigationContext.self))
}
