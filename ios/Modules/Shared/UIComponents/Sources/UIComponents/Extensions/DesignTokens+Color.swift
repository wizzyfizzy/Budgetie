//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

public extension Color {
    static let btWhite = Color("btWhite", bundle: .module)
    static let btBlack = Color("btBlack", bundle: .module)
    static let btBlue = Color("btBlue", bundle: .module)
    static let btLightGreen = Color("btLightGreen", bundle: .module)
    static let btDarkGreen = Color("btDarkGreen", bundle: .module)
    static let btGreen = Color("btGreen", bundle: .module)
    static let btLightGrey = Color("btLightGrey", bundle: .module)
    static let btGray = Color("btGray", bundle: .module)
    static let btLightYellow = Color("btLightYellow", bundle: .module)
    static let btOrange = Color("btOrange", bundle: .module)
    static let btRed = Color("btRed", bundle: .module)
    
    enum Opacity {
        public static let small: Double = 0.1
        public static let medium: Double = 0.15
        public static let large: Double = 0.2
        public static let card: Double = 0.12
        public static let full: Double = 1
    }
}
