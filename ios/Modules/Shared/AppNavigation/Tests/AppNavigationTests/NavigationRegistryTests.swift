//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import XCTest
import SwiftUI
import AppNavigationAPI
@testable import AppNavigation

final class NavigationRegistryTests: XCTestCase {
    
    struct TestNavigationData: NavigationData {}
    struct TestAnotherNavigationData: NavigationData {}

    private func arrange() -> (registry: NavigationRegistry,
                               navData: TestNavigationData) {
        let registry = NavigationRegistry()
        let navData = TestNavigationData()
        return (registry, navData)
    }
    
    func testRegistryResolveView() {
        let arrange = arrange()
        let registry = arrange.registry
        registry.registerView(TestNavigationData.self) { _ in
            AnyView(Text("Hello!!"))
        }
        let resolved = registry.resolveView(data: arrange.navData)
        XCTAssertNotNil(resolved)
    }
    
    func testRegistryResolveView_forUnregisteredView() {
        let arrange = arrange()
        let registry = arrange.registry
        let resolved = registry.resolveView(data: arrange.navData)
        XCTAssertNil(resolved)

        registry.registerView(TestNavigationData.self) { _ in
            AnyView(Text("Hello!!"))
        }
        
        let anotherResolved = registry.resolveView(data: TestAnotherNavigationData())
        XCTAssertNil(anotherResolved)
    }
    
}
