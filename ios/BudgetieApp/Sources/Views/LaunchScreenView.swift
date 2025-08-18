//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

struct LaunchScreenView: View {
    @Binding var showLaunch: Bool

    private let background = LinearGradient(colors: [Color.btLightGreen, Color.btLightYellow],
                                    startPoint: .top,
                                    endPoint: .bottom)
    private let imageHeight: CGFloat = 400
    var body: some View {
        VStack(spacing: Spacing.spaceM) {
            Image("launch")
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
            Text("Master your money!")
                .font(.appTitle)
                .frame(alignment: .center)
                .foregroundColor(.btBlack)
            Text("Budget it with style!")
                .font(.appTitle)
                .frame(alignment: .center)
                .foregroundColor(.btBlack)
            Spacer()
        }
        .background(background)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showLaunch = false
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    @State static var showLaunch = true

    static var previews: some View {
        LaunchScreenView(showLaunch: $showLaunch)
            .previewDevice("iPhone 14 Pro")
            .previewDisplayName("Launch Screen Preview")
    }
}
