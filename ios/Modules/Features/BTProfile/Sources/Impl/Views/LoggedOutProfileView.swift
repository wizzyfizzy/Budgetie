//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents
import AuthAPI

struct LoggedOutProfileView: View {
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: "lock.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(.gray.opacity(0.7))
                .accessibilityHidden(true)
            
            Text("Sign in to unlock your profile and manage your settings.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
                .accessibilityLabel("You need to sign in to unlock your profile and manage your settings")
            
            Button {
//                navigateToUC.execute(data: AuthAPI.AuthFlowNavData(), type: .sheet)
            } label: {
                Text("Login")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.horizontal, 40)
            .accessibilityLabel("Login")
            .accessibilityHint("Tap to sign in to your account")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
//        .sheet(item: $navContext.sheetView) { wrapper in
//            wrapper.view
//                .interactiveDismissDisabled(true)
//        }
    }
}
