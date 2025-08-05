//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import DIModuleAPI
@testable import DIModule
import XCTest

extension XCTestCase {
    /// Tests that the running the given `closure` returns in a `fatalError()` call.
    func expectFatalError(file: StaticString = #file,
                          line: UInt = #line,
                          closure: @escaping () -> Void) {
        let expectation = expectation(description: "Expecting fatalError to be called")
        
        // Override
        overrideFatalError { message, _, _ in
            expectation.fulfill()
            /// Dummy method that returns Never. Without it we have compile errors
            repeat {
                RunLoop.current.run()
            } while true
        }
        
        let uuid = UUID().uuidString
        DispatchQueue(label: uuid).async(execute: closure)

        let result = XCTWaiter.wait(for: [expectation], timeout: 1, enforceOrder: false)
        switch result {
        case .timedOut:
            restoreFatalError()
            XCTFail("Expect Fatal Error", file: file, line: line)
        default:
            restoreFatalError()
        }
    }
}
