//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation
import DIModuleAPI

/// A lightweight Dependency Injection Container to register and resolve instances across modules.
open class DIContainer: DIResolver {
    
    /// Stores closures for creating instances lazily when needed.
    private var factories: [ObjectIdentifier: (DIResolver) -> Any] = [:]
    /// Stores concrete instances registered directly.
    private var instances: [ObjectIdentifier: Any] = [:]

    /// A global default singleton instance.
    public static var `default` = DIContainer()
    
    // MARK: Initializers
    public init() {}

    // MARK: Registering instances and factories

    /// Registers a service using a factory closure (lazy initialization).
    /// - Parameters:
    ///   - type: The type of the service to register.
    ///   - factory: A closure that returns an instance of the service.
    public func register<T>(_ type: T.Type, factory: @escaping (DIResolver) -> T) {
        let key = ObjectIdentifier(type)
        factories[key] = factory
    }

    /// Registers a concrete instance directly.
    /// - Parameters:
    ///   - type: The type of the service to register.
    ///   - instance: The instance to be used.
    public func register<T>(_ type: T.Type, instance: T) {
        let key = ObjectIdentifier(type)
        instances[key] = instance
    }

    // MARK: - Resolver Implementation

    /// Resolves a dependency of the specified type by returning a previously registered instance
    /// or by invoking a registered factory to create one.
    /// - Parameter type: The type of the dependency to resolve. This is inferred automatically in most cases.
    /// - Returns: An instance of the requested type. If the dependency is not registered, the app will crash.
    public func resolve<T>(_ type: T.Type = T.self) -> T {
        let key = ObjectIdentifier(type)

        // If an instance has already been created and cached, return it.
        if let instance = instances[key] as? T {
            return instance
        }

        // Otherwise, find the factory for this type.
        guard let factory = factories[key] else {
            fatalError("DI: No registered entry for \(type)")
        }

        // Create the instance using the factory, and ensure it can be cast to the requested type.
        guard let created = factory(self) as? T else {
            fatalError("DI: Failed to cast factory output to expected type: \(type)")
        }

        return created
    }

}
