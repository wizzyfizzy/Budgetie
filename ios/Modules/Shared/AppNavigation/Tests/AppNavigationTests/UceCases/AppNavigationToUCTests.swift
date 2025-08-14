//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import XCTest
import AppNavigationAPI
@testable import AppNavigation

final class AppNavigationToUCTests: XCTestCase {
    struct TestNavigationData: NavigationData {}
    struct AnotherNavigationData: NavigationData {}

    func testExecute_forPush() {
        let expectation = XCTestExpectation(description: "Push view is called")
        let navigationUC = AppNavigateToUCImpl { data, type in
            XCTAssertTrue(data is TestNavigationData)
            XCTAssertEqual(type, .push)
            expectation.fulfill()
        }
        
        navigationUC.execute(data: TestNavigationData(), type: .push)
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testExecute_forSheet() {
        let expectation = XCTestExpectation(description: "Sheet view is called")
        let navigationUC = AppNavigateToUCImpl { data, type in
            XCTAssertTrue(data is TestNavigationData)
            XCTAssertEqual(type, .sheet)
            expectation.fulfill()
        }
        
        navigationUC.execute(data: TestNavigationData(), type: .sheet)
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testExecute_DifferentDataType() {
        let expectation = XCTestExpectation(description: "Handler called with different data type")
        let navigationUC = AppNavigateToUCImpl {data, type in
            XCTAssertTrue(data is AnotherNavigationData)
            XCTAssertEqual(type, .push)
            expectation.fulfill()
        }
        navigationUC.execute(data: AnotherNavigationData(), type: .push)
    }
}
