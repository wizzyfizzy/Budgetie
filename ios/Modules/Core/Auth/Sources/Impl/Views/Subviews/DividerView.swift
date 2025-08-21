//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

struct DividerView: View {
    
    var body: some View {
        HStack {
            Rectangle().frame(height: 1).opacity(0.2)
            Text("or")
                .font(.caption)
                .foregroundStyle(.secondary)
            Rectangle().frame(height: 1).opacity(0.2)
        }
    }
}

#Preview {
    DividerView()
}
