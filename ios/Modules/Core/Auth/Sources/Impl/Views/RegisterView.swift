//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

struct RegisterView: View {
    @Binding var path: [AuthRoute]
//    @StateObject private var registerVM: registerVM = RegisterVM()

    init(path: Binding<[AuthRoute]>) {
        _path = path
    }

    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    RegisterView(path: .constant([]))
}
