//
// Copyright © 2019 ___ORGANIZATIONNAME___
// All rights reserved.
//

import SwiftUI
import UIComponents

public struct SubscriptionsView: View {
    public var body: some View {
        VStack {
            Spacer()
            Text("Subscriptions")
                .font(.appTitle)
                .foregroundColor(.btBlack)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
