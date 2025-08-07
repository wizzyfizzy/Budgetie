//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import DIModule
import AppLogging

final class BTAppDI: DIContainer {
    static var shared = DIContainer()
    
    let isEmpty: Bool
    
    init(isEmpty: Bool = false) {
        self.isEmpty = isEmpty
        super.init()
        
        BTAppDI.shared = self
        
        if !isEmpty {
            registerLogging()
        }
    }
    
    static func setUp() {
        clear()
        shared = BTAppDI()
    }
    
    static func clear() {
        shared = DIContainer()
    }
    
    private func registerLogging() {
        register(BTLogger.self) { _ in logger(module: "MainApp") }
    }
}
