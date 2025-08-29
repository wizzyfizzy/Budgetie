//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

struct ProfileSettings: Codable {
    let isDarkMode: Bool
    let language: String
    let notificationsEnabled: Bool
    let reminderTime: Date
    let appVersion: String
    let deviceName: String
}
