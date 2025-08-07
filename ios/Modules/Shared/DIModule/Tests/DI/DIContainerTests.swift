//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

@testable import DIModule
import DIModuleAPI
import XCTest

final class DIContainerTests: XCTestCase {
 
    // MARK: Testing instances
    
    func testInstanceResolve() {
        let container = DIContainer()
        container.register(String.self, instance: String("injected"))
        XCTAssertEqual(container.resolve(String.self), "injected")
        
        let service = TestService()
        container.register(TestService.self, instance: service)

        let resolved: TestService = container.resolve()
        XCTAssertTrue(resolved === service)
        XCTAssertEqual(resolved.value, "TestService injected")
    }

    func testInstanceResolve_shouldCrashIfNotRegistered() {
        let container = DIContainer()
        container.register(String.self, instance: String("injected"))
        expectFatalError {
            let _: Double = container.resolve()
            let _: TestService = container.resolve()
        }
    }
    
    func testInstance_registerType() {
        let container = DIContainer()
        container.register(String.self, instance: String("a String"))
        XCTAssertEqual(container.resolve(String.self), "a String")
    }

    func testInstance_nullableResolve() {
        let container = DIContainer()
        container.register(String.self, instance: String("a String"))

        let value: String = container.resolve()
        XCTAssertEqual(value, String("a String"))

        expectFatalError {
            let _: Double = container.resolve()
        }
    }

    // MARK: Testing factories

    func testFactoryResolve() {
        let container = DIContainer()
        container.register(String.self) { _ in
            "Injected"
        }
        XCTAssertEqual(container.resolve(), "Injected")

        container.register(TestService.self) { _ in
            let service = TestService()
            service.value = "Injected from factory"
            return service
        }

        let resolved: TestService = container.resolve()
        XCTAssertEqual(resolved.value, "Injected from factory")
        
        container.register(TestService.self) { _ in TestService()
        }
        let resolved1: TestService = container.resolve()
        let resolved2: TestService = container.resolve()

        // Should be different instances
        XCTAssertFalse(resolved1 === resolved2)
    }

    func testFactoryResolve_shouldCrashIfNotRegistered() {
        let container = DIContainer()
        container.register(String.self) { _ in
            "Injected"
        }
        expectFatalError {
            let _: Double = container.resolve()
            let _: TestService = container.resolve()
        }
    }
    
    func testFactory_registerType() {
        let container = DIContainer()
        container.register(String.self) { _ in
            "a String"
        }
        XCTAssertEqual(container.resolve(String.self), "a String")
    }

    func testFactory_nullableResolve() {
        let container = DIContainer()
        container.register(String.self) { _ in
            "a String"
        }

        let value: String = container.resolve()
        XCTAssertEqual(value, String("a String"))

        expectFatalError {
            let _: Double = container.resolve()
        }
    }
    
    func testSubDependencies() {
        let container = DIContainer()
        container.register(TestService.self, instance: TestService())
        container.register(TestServiceProtocol.self) { _ in TestService2() }
        container.register(TestServiceProtocol.self) { _ in TestServiceStruct() }
        container.register(ClassWithDependencies.self) { _ in ClassWithDependencies() }
      
        DIContainer.default = container
        let resolved: ClassWithDependencies = DIContainer.default.resolve()

        XCTAssertNotNil(resolved)
    }
    
    private class TestService {
        var value: String = "TestService injected"
    }
   
    private class TestService2: TestServiceProtocol {
        var value: String = "TestService2 injected"
    }
    
    private struct TestServiceStruct: TestServiceProtocol {
        var value: String = "TestServiceStruct injected"
    }
    
    private class ClassWithDependencies {
        let classProtocol: TestServiceProtocol = DIContainer.default.resolve()
    }
}

private protocol TestServiceProtocol {
    var value: String { get set }
}
