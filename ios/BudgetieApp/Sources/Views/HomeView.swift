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
            tabsView
        }
        .onAppear {
            if shouldShowOnboardingUC.execute() {
//                navigateToUC.execute(data: OnboardingAPI.OnboardingNavData(), type: .push)
                navigateToUC.execute(data: OnboardingAPI.OnboardingNavData(), type: .sheet)
            }
        }
        .sheet(item: $navContext.sheetView) { wrapper in
            wrapper.view
                .interactiveDismissDisabled(true)
        }
    }
    
    @ViewBuilder
    var tabsView: some View {
        TabView {
            DashboardNavigationViewProvider.buildView()
                .tabItem {
                    Label {
                        Text(TextKeys.textTabTitle1.localized())
                    } icon: {
                        Image(ImageKeys.imageTab1)
                            .renderingMode(.template)
                    }
                }
            DashboardNavigationViewProvider.buildView()
                .tabItem {
                    Label {
                        Text(TextKeys.textTabTitle2.localized())
                    } icon: {
                        Image(ImageKeys.imageTab2)
                            .renderingMode(.template)
                    }
                }
            DashboardNavigationViewProvider.buildView()
                .tabItem {
                    Label {
                        Text(TextKeys.textTabTitle3.localized())
                    } icon: {
                        Image(ImageKeys.imageTab3)
                            .renderingMode(.template)
                    }
                }
            DashboardNavigationViewProvider.buildView()
                .tabItem {
                    Label {
                        Text(TextKeys.textTabTitle4.localized())
                    } icon: {
                        Image(ImageKeys.imageTab4)
                            .renderingMode(.template)
                    }
                }
        }
        .tint(.btGreen)
    }
}

#Preview {
    HomeView(navContext: BTAppDI.shared.resolve(NavigationContext.self))
}
