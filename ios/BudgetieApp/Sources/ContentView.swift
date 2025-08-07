//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import AppLogging

struct ContentView: View {
    @Injected private var logger: BTLogger
    
    var body: some View {
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

#Preview {
    ContentView()
}
