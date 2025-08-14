//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import AppNavigationAPI
import AppNavigationMocks
import XCTest
@testable import Budgetie
import SwiftUI

final class NavigationContextTests: XCTestCase {
    struct TestNavigationData: NavigationData {}

    private func arrange() -> (registry: NavigationRegistryProtocolMock,
                               navigationContext: NavigationContext,
                               navData: TestNavigationData) {
        let registry = NavigationRegistryProtocolMock()
        let navigationContext = NavigationContext(registry: registry)
        let navData = TestNavigationData()
        
        return(registry,
               navigationContext,
               navData)
    }
    
    func testNavigationHandler_withPush() {
        // Arrange
        let arrange = arrange()
        arrange.registry.stub.resolveViewClosure = { _ in AnyView(Text("Hello pushed view"))}
        let exp = expectation(description: "Navigation update")

        // Act
        arrange.navigationContext.navigationHandler(arrange.navData, .push)
        
        // Assert
        DispatchQueue.main.async {
            XCTAssertEqual(arrange.navigationContext.path.count, 1)
            XCTAssertNil(arrange.navigationContext.sheetView)
            XCTAssertEqual(arrange.navigationContext.path.first?.view.typeErasedEqual(to: AnyView(Text("Hello pushed view"))), true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func testNavigationHandler_withSheet() {
        // Arrange
        let arrange = arrange()
        arrange.registry.stub.resolveViewClosure = { _ in AnyView(Text("Hello sheet view"))}
        let exp = expectation(description: "Navigation update")

        // Act
        arrange.navigationContext.navigationHandler(arrange.navData, .sheet)
        
        // Assert
        DispatchQueue.main.async {
            XCTAssertNotNil(arrange.navigationContext.sheetView)
            XCTAssertEqual(arrange.navigationContext.path.count, 0)
            XCTAssertEqual(arrange.navigationContext.sheetView?.view.typeErasedEqual(to: AnyView(Text("Hello sheet view"))), true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
}

extension AnyView {
    /// Compares two `AnyView` instances by checking only the underlying view type.
    /// - Important: This does **not** compare view content or state.
    ///   For example, `Text("A")` and `Text("B")` will be considered equal
    ///   because they are both of type `Text`.
    /// - Parameter other: The `AnyView` to compare with.
    /// - Returns: `true` if both views wrap the same underlying type, `false` otherwise.
    func typeErasedEqual(to other: AnyView) -> Bool {
        type(of: self) == type(of: other)
    }
}
