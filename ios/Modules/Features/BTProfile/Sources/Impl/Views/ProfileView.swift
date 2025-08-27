//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents
import AuthAPI

public struct ProfileView: View {
    @Binding var path: [ProfileRoute]
    
    @StateObject private var viewModel: ProfileVM = ProfileVM()
    
    init(path: Binding<[ProfileRoute]>) {
        _path = path
    }
    
    public var body: some View {
        if viewModel.isLoggedIn, let user = viewModel.userData {
            LoggedInProfileView(path: $path, viewModel: viewModel, user: user)
        } else {
            LoggedOutProfileView()
        }
    }
}
