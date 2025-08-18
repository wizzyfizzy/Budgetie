//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI

public extension Font {
    // MARK: - Titles
    static var appTitle: Font {
        scaledUIFont(size: 26, weight: .bold, textStyle: .title1)
    }
    
    // MARK: - Body
    static var appBody: Font {
        scaledUIFont(size: 17, weight: .regular, textStyle: .body)
    }
    
    static var appBodyBold: Font {
        scaledUIFont(size: 17, weight: .bold, textStyle: .body)
    }
    
    // MARK: - Buttons
    static var appButton: Font {
        scaledUIFont(size: 17, weight: .semibold, textStyle: .callout)
    }
    
    static var appTextButton: Font {
        scaledUIFont(size: 15, weight: .medium, textStyle: .callout)
    }
    
    // MARK: - Caption
    static var appCaption: Font {
        scaledUIFont(size: 13, weight: .regular, textStyle: .caption1)
    }
    
    static var appCaptionBold: Font {
        scaledUIFont(size: 13, weight: .bold, textStyle: .caption1)
    }
    
    // MARK: - Helper
    private static func scaledUIFont(size: CGFloat, weight: UIFont.Weight, textStyle: UIFont.TextStyle) -> Font {
        let uiFont = UIFont.systemFont(ofSize: size, weight: weight)
        let scaled = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: uiFont)
        return Font(scaled)
    }
}
