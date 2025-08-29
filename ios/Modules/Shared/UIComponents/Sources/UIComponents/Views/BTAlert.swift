//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

public enum BTAlert: Identifiable, Equatable {
    public var id: String {
        switch self {
        case .success(_, let message):
            return "success_\(message)"
        case .error(_, let message):
            return "error_\(message)"
        case .info(_, let message):
            return "info_\(message)"
        }
    }

    case success(String, String)
    case error(String, String)
    case info(String, String)
    
    /// Provides the corresponding SwiftUI Alert
    public func toAlert(
        dismissAction: (() -> Void)? = nil,
        primaryButtonAction: (() -> Void)? = nil,
        secondaryButtonAction: (() -> Void)? = nil) -> Alert {
        switch self {
        case .success(let title, let message):
            return Alert(
                title: Text(LocalizedStringKey(title)),
                message: Text(LocalizedStringKey(message)),
                dismissButton: .default(Text("OK"), action: dismissAction)
            )
        case .error(let title, let message):
            return Alert(
                title: Text(LocalizedStringKey(title)),
                message: Text(LocalizedStringKey(message)),
                dismissButton: .default(Text("OK"), action: dismissAction)
            )
        case .info(let title, let message):
            return Alert(
                title: Text(LocalizedStringKey(title)),
                message: Text(LocalizedStringKey(message)),
                primaryButton: .default(Text("Yes"), action: primaryButtonAction),
                secondaryButton: .cancel(Text("Cancel"), action: secondaryButtonAction)
            )
        }
    }
}
