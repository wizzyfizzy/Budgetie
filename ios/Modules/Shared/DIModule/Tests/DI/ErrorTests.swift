//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModuleAPI
@testable import DIModule
import XCTest

final class ErrorTests: XCTestCase {
  
    func testExpectFatalError() {
        var called = false
        
        expectFatalError {
            called = true
            fatalError("Injected crash")
        }
        XCTAssertTrue(called)
    }

    func testExpectFatalError_noMessage() {
        var called = false

        expectFatalError {
            called = true
            fatalError()
        }
        XCTAssertTrue(called)
    }
}
