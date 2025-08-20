//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String?
    
    var body: some View {
        if let errorMessage {
            Text(errorMessage)
                .font(.appBody)
                .foregroundStyle(Color.btRed)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityIdentifier("login_error")
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "Invalid")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
