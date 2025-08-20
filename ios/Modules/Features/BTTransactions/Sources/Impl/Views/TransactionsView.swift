//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

public struct TransactionsView: View {
    public var body: some View {
        VStack {
            Spacer()
            Text("Transactions")
                .font(.appTitle)
                .foregroundColor(.btBlack)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
