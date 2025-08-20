//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

enum AuthRoute: Hashable {
    case login
    case register
    case forgotPassword
}

struct AuthFlowView: View {
    @State private var path: [AuthRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(path: $path)
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .login:
                        LoginView(path: $path)
                    case .register:
                        RegisterView(path: $path)
                    case .forgotPassword:
                        ForgotPasswordView(path: $path)
                    }
                }
        }
    }
}
